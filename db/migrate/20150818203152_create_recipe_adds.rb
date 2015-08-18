class CreateRecipeAdds < ActiveRecord::Migration
  def change
    create_table :recipe_adds do |t|
      t.integer :user_id, null: false
      t.integer :recipe_id, null: false
      
      t.timestamps null: false
    end
  end
end
