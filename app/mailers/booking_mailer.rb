class BookingMailer < ApplicationMailer
  
  def new_booking(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Thanks for your booking')
  end
  
  def cancel_booking(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Cancel booking')
  end
  
  def engage_booking(booking)
    @booking = booking
    mail(to: @booking.nurse.email, subject: 'Pick the booking')
  end
  
  def disengage_booking(booking)
    @booking = booking
    mail(to: @booking.nurse.email, subject: 'Let go the booking')
  end
end
