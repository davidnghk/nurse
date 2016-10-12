json.array!(@clients) do |client|
  json.extract! client, :id, :code, :name, :chi_name
  json.url client_url(client, format: :json)
end
