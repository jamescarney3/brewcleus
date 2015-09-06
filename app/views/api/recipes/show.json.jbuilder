json.partial! "api/recipes/recipe", recipe: @recipe
json.author_username @recipe.author.username
json.image_url asset_path(@recipe.image.url(:medium))


json.yield @recipe.yield
json.original_grav @recipe.original_grav
json.final_grav @recipe.final_grav
json.abv @recipe.abv
json.ibus @recipe.ibus

avg_rating = @recipe.exp(:rating)
json.avg_rating avg_rating ? number_with_precision(avg_rating, precision: 2) : nil

avg_o_grav = @recipe.exp(:original_grav, 3)
json.avg_o_grav avg_o_grav ? number_with_precision(avg_o_grav, precision: 3) : nil

avg_f_grav = @recipe.exp(:final_grav, 3)
json.avg_f_grav avg_f_grav ? number_with_precision(avg_f_grav, precision: 3) : nil

json.avg_abv @recipe.exp_abv

avg_yield = @recipe.exp(:yield, 1)
json.avg_yield avg_yield ? number_with_precision(avg_yield, precision: 2) : nil

avg_ibus = @recipe.exp(:ibus).round
json.avg_ibus avg_ibus

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
