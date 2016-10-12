json.array!(@issues) do |issue|
  json.extract! issue, :id, :name, :chi_name
  json.url issue_url(issue, format: :json)
end
