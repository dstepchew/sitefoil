json.array!(@triggers) do |trigger|
  json.extract! trigger, :id, :name, :description, :channel_id
  json.url trigger_url(trigger, format: :json)
end
