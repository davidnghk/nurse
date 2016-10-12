json.array!(@devices) do |device|
  json.extract! device, :id, :name, :chi_name
  json.url device_url(device, format: :json)
end
