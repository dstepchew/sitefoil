json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :status, :hits, :description
  json.url recipe_url(recipe, format: :json)
end
