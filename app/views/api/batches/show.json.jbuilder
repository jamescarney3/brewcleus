json.partial! "api/batches/batch", batch: @batch
json.recipe_name @batch.recipe.name
json.recipe_author @batch.recipe.author.username

json.yield @batch.yield if @batch.yield
json.original_grav @batch.original_grav if @batch.original_grav
json.final_grav @batch.final_grav if @batch.final_grav
json.bottle_date @batch.bottle_date if @batch.bottle_date
json.procedure_notes @batch.procedure_notes if @batch.procedure_notes
json.comments @batch.comments if @batch.comments
