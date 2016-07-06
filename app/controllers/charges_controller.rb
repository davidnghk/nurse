class ChargesController < ApplicationController

  def new
  end  
  
  def create
    @booking = Booking.find(params[:booking_id])
    @charge = Charge.new(charge_params)
    @charge.booking_id = @booking.id
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @charge.booking.fee * 100,
      :description => 'Rails Stripe customer',
      :currency    => 'hkd'
    )
    @charge.save
    
    @booking.confirm!
    @booking.pay!
    BookingMailer.delay.confirm_booking_to_user(@booking)
    BookingMailer.delay.confirm_booking_to_nurse(@booking)
    redirect_to booking_path(@booking)
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  
  def charge_params
    params.require(:charge).permit(:booking_id, :charge_datetime)
  end
  
end