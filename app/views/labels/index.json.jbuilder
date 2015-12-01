json.array!(@labels) do |label|
  json.extract! label, :id
  json.url label_url(label, format: :json)
end
