class Ingredient < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many(
    :recipe_ingredients,
    class_name: "RecipeIngredient",
    foreign_key: :ingredient_id,
    primary_key: :id
  )
  
end
