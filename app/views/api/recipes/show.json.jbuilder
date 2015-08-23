json.partial! "api/recipes/recipe", recipe: @recipe
json.author_username @recipe.author.username

json.yield @recipe.yield if @recipe.yield
json.original_grav @recipe.original_grav if @recipe.original_grav
json.final_grav @recipe.final_grav if @recipe.final_grav
json.ibus @recipe.ibus if @recipe.ibus

json.recipe_ingredients do
  json.array! @recipe.recipe_ingredients do |recipe_ingredient|
    json.extract! recipe_ingredient, :id, :ingredient_id, :amount, :units
    json.ingredient_name recipe_ingredient.ingredient.name
  end
end

json.users do
  json.array! @recipe.users do |user|
    json.extract! user, :id, :username
  end
end

json.batches do
  json.array! @recipe.batches do |batch|
    json.extract! batch, :id, :user_id, :brew_date, :rating, :comments
    json.user_username batch.user.username
  end
end
