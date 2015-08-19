class RecipeAdd < ActiveRecord::Base
  validates :user_id, :recipe_id, presence: true
  validate :user_is_not_author, :not_already_followed

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
    if Recipe.find(self.recipe_id).author_id == self.user_id
      errors.add(:user_id, "User is already recipe author")
    end
  end

  def not_already_followed
    if User.find(self.user_id).recipe_adds.pluck("recipe_id").include?(self.recipe_id)
      errors.add(:user_id, "Recipe already added for this user")
    end
  end

end
