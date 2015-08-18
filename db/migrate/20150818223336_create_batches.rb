class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.integer :user_id, null: false
      t.integer :recipe_id, null: false
      t.date :brew_date, null: false
      t.integer :rating, null: false

      t.float :yield
      t.float :original_grav
      t.float :final_grav
      t.float :ibus
      t.date :bottle_date

      t.text :procedure_notes
      t.text :comments

      t.timestamps null: false
    end
  end
end
