class Recipe < ActiveRecord::Base

  validates :author_id, :name, :style, :description, presence: true
  validates :name, uniqueness: true
  validate :current_user_authorized, on: :update

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :recipe_adds,
    class_name: "RecipeAdd",
    foreign_key: :recipe_id,
    primary_key: :id
  )

  has_many(
    :users,
    through: :recipe_adds,
    source: :user
  )

  has_many(
    :recipe_ingredients,
    class_name: "RecipeIngredient",
    foreign_key: :recipe_id,
    primary_key: :id
  )

  has_many(
    :ingredients,
    through: :recipe_ingredients,
    source: :ingredient
  )

  has_many(
    :batches,
    class_name: "Batch",
    foreign_key: :recipe_id,
    primary_key: :id
  )

  private

  def current_user_authorized
    unless self.author_id != current_user.id
      errors.add(:author_id, "User not authorized to edit this recipe")
    end
  end

end
