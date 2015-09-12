json.array! @recipes.each do |recipe|
  json.partial! "api/recipes/recipe", recipe: recipe
  json.author recipe.author.username
  json.image_url asset_path(recipe.image.url(:medium))
end
