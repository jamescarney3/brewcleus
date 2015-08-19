json.partial! "api/batches/batch", batch: @batch
json.yield @batch.yield || "pending"
json.original_grav @batch.original_grav || "pending"
json.final_grav @batch.final_grav || "pending"
json.bottle_date @batch.bottle_date || "pending"
json.procedure_notes @batch.procedure_notes || "pending"
json.comments @batch.comments || "pending"
