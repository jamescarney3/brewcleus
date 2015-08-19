json.array! @ingredients.each do |ingredient|
  json.extract! ingredient, :id, :name
end
