class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.integer :ingredient_id, null: false
      t.integer :recipe_id, null: false
      t.float :amount, null: false
      t.string :units, null: false

      t.boolean :verified, default: true

      t.timestamps null: false
    end
  end
end
