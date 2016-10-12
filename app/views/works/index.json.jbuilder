json.array!(@works) do |work|
  json.extract! work, :id, :name, :chi_name
  json.url work_url(work, format: :json)
end
