class Recipe < ActiveRecord::Base

  validates :author_id, :name, :style, :description, presence: true
  validates :name, uniqueness: true

  has_attached_file :image,
    styles: { medium: "300x300#", thumb: "60x60#" },
    default_url: "nounprojecthopcone.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

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

end
