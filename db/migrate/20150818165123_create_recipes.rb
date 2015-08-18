class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :author_id, null: false
      t.string :name, null: false
      t.string :style, null: false
      t.text :description, null: false

      t.float :yield
      t.float :original_grav
      t.float :final_grav
      t.float :ibus

      t.timestamps null: false
    end
  end
end
