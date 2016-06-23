json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :datetime, :duration, :hospital, :location, :server_grade, :server_id, :contact_person, :contact_phone_no, :fee
  json.url order_url(order, format: :json)
end
