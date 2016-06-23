class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
#  def open
#    @orders = Order.open?
#  end
  
  # GET /orders
  # GET /orders.json
  def index
#   @orders = Order.all
    case current_user.role
    when :partner
#      @orders = Order.where('server_id = ? or aasm_state.pending?', current_user.id)      
      @orders = Order.all
    when :admin
      @orders = Order.all
    else
#            @orders = Order.where('user_id = ? ', current_user.id)
      @orders = Order.all
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

#   POST /orders
#   POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user

    respond_to do |format|
       if @order.save
#      if @order.save_with_payment
        format.html { redirect_to @order, notice: 'Thanks for placing your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected

#    def configure_permitted_parameters
#      devise_parameter_sanitizer.for(:new).push(:payment)
#    end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :datetime, :duration, :hospital, :location, :server_grade, :server_id, :contact_person, :contact_phone_no, :fee, :booking_date, :booking_time, :stripe_customer_token, :stripe_card_token, :stripe_charge_token)
    end
end
