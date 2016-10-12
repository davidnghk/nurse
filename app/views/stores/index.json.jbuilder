json.array!(@stores) do |store|
  json.extract! store, :id, :client_id, :code, :name, :chi_name, :address, :chi_address, :district_id
  json.url store_url(store, format: :json)
end
