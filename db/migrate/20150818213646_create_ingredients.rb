class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :ingredients, :name, unique: true
    add_index :recipes, :name, unique: true
  end
end
