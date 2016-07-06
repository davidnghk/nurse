class BookingMailer < ApplicationMailer
  
  def new_booking_to_user(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Thanks for your booking')
  end
  def new_booking_to_nurses(booking)
    @booking = booking
    if @booking.Open?
      @partner = User.partner.Approved
      @partner.each do |partner| 
        mail(to: partner.email, subject: 'New booking Available')
      end 
    end
  end
  
  def cancel_booking_to_user(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Cancel booking')
  end
  def cancel_booking_to_nurse(booking)
    @booking = booking
    if @booking.nurse
      mail(to: @booking.nurse.email, subject: 'Cancel booking')
    end
  end

  def confirm_booking_to_user(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Pick the booking')
  end
  def confirm_booking_to_nurse(booking)
    @booking = booking
    mail(to: @booking.nurse.email, subject: 'Pick the booking')
  end
  
  def engage_booking_to_user(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Pick the booking')
  end
  def engage_booking_to_nurse(booking)
    @booking = booking
    mail(to: @booking.nurse.email, subject: 'Pick the booking')
  end
  
  def disengage_booking_to_nurse(booking)
    @booking = booking
    mail(to: @booking.nurse.email, subject: 'Let go the booking')  
  end
  def disengage_booking_to_user(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Let go the booking')
  end
  
  def reject_booking_to_user(booking)
    @booking = booking
    mail(to: @booking.user.email, subject: 'Booking Rejected')
  end
  def reject_booking_to_nurse(booking)
    @booking = booking
    mail(to: @booking.nurse.email, subject: 'Booking Rejected')
  end
  
end

