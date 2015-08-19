class RecipeIngredient < ActiveRecord::Base

  validates :recipe_id, :ingredient_id, presence: true
  validate :is_not_already_included

  belongs_to(
    :recipe,
    class_name: "Recipe",
    foreign_key: :recipe_id,
    primary_key: :id
  )

  belongs_to(
    :ingredient,
    class_name: "Ingredient",
    foreign_key: :ingredient_id,
    primary_key: :id
  )

  private

  def is_not_already_included
    if Recipe.find(self.recipe_id).recipe_ingredients.pluck("ingredient_id").include?(self.ingredient_id)
      errors.add(:ingredient_id, "Recipe already includes selected ingredient")
    end
  end

end
