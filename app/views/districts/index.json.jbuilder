json.array!(@districts) do |district|
  json.extract! district, :id, :code, :name, :chi_name
  json.url district_url(district, format: :json)
end
