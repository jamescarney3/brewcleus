class RecipeAdd < ActiveRecord::Base
  validates :user_id, :recipe_id, presence: true
  validate :user_is_not_author
  validate :not_already_followed

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :recipe,
    class_name: "Recipe",
    foreign_key: :recipe_id,
    primary_key: :id
  )

  private

  def user_is_not_author
    Recipe.find(self.recipe_id).author != User.find(self.user_id)
  end

  def not_already_followed
    User.find(self.user_id).added_recipes.include?(Recipe.find(self.recipe_id))
  end

end
