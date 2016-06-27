json.array!(@bookings) do |booking|
  json.extract! booking, :id, :user_id, :order_datetime, :hours, :hospital, :location, :fee, :cost, :contact_person, :contact_phone_no, :payment_token
  json.url booking_url(booking, format: :json)
end
