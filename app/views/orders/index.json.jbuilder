json.array!(@orders) do |order|
  json.extract! order, :id, :store_id, :call_date, :repair_date, :status, :technician_id, :device_id, :issue_id, :work_id
  json.url order_url(order, format: :json)
end
