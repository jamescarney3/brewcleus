json.array! @recipes.each do |recipe|
  json.extract! recipe, :id, :author_id, :name, :style
  json.author recipe.author.username
  json.image_url asset_path(recipe.image.url(:small))
end
