json.partial! "api/batches/batch", batch: @batch
json.recipe_name @batch.recipe.name
json.user_name @batch.user.username
json.recipe_author @batch.recipe.author.username
json.recipe_author_id @batch.recipe.author.id

json.abv @batch.abv

json.extract! @batch, :yield, :original_grav, :final_grav, :ibus, :brew_date,
  :bottle_date, :procedure_notes, :comments
