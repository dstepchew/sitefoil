json.array!(@channels) do |channel|
  json.extract! channel, :id, :name, :status, :description
  json.url channel_url(channel, format: :json)
end
