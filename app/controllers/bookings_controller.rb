class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, 
    :cancel, :engage, :disengage, :complete, :expire, :reject]

  def cancel
    @booking.cancel!
    BookingMailer.delay.cancel_booking_to_user(@booking)
    BookingMailer.delay.cancel_booking_to_nurse(@booking)
    redirect_to bookings_path  
  end
  
  def engage
    @booking.nurse = current_user
    @booking.engage!
    BookingMailer.delay.engage_booking_to_user(@booking)
    BookingMailer.delay.engage_booking_to_nurse(@booking)
    redirect_to bookings_path 
  end
  
  def disengage
    BookingMailer.delay.disengage_booking_to_nurse(@booking)
    @booking.nurse = nil 
    @booking.disengage!
    BookingMailer.delay.disengage_booking_to_user(@booking)
    redirect_to bookings_path 
  end
  
  def expire
    redirect_to bookings_path  if @booking.expire!
  end
  
  def complete
    redirect_to bookings_path  if @booking.complete!
  end
  
  def reject
    BookingMailer.delay.reject_booking_to_user(@booking)
    if @booking.Matched?
      BookingMailer.delay.reject_booking_to_nurse(@booking)
    end 
    redirect_to bookings_path  if @booking.reject!
  end
  
  # GET /bookings
  # GET /bookings.json
  def index
    if current_user.customer? 
      @bookings = Booking.where(" user_id = ?", current_user.id).order('order_datetime desc')
    elsif current_user.admin?
      @bookings = Booking.all.order(order_datetime: :desc)
    else
      @bookings = Booking.where("nurse_id = ? or status = ? ",  current_user.id, Booking.statuses[:Open]).order(order_datetime: :desc)
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
  @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.payment_token = params[:stripeToken]
    if @booking.order_datetime
      if @booking.order_datetime < Date.today + 1.day
        @booking.fee  = 0
        @booking.cost = 0
        @booking.status = :Rejected
        @booking.payment = :NotPaid
      else
        if @booking.hours == 4
          @booking.fee  = 1100
          @booking.cost = 800
        elsif @booking.hours == 8
          @booking.fee  = 1900
          @booking.cost = 1500
        else
          @booking.fee  = 2700
          @booking.cost = 2200
        end

        customer = Stripe::Customer.create(
          :email => params[:stripeEmail],
          :source  => params[:stripeToken]
        )

        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @booking.fee * 100,
          :description => 'Nurse: '+@booking.user.name,
          :currency    => 'hkd'
        )
        @booking.status = :Open
        @booking.payment = :Paid
        end
      end
    respond_to do |format|
      if @booking.save 
        BookingMailer.delay.new_booking_to_user(@booking)
        if @booking.Open?
          BookingMailer.delay.new_booking_to_nurses(@booking)
        end
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_booking_path
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:user_id, :order_datetime, :hours, :hospital, :status, :location, :fee, :cost, :contact_person, :contact_phone_no, :payment_token, :nurse_id, :preferred_language, 
        :notes)
    end
end
