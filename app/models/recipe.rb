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

  def exp(att, decimals = 2)
    vals = batches.pluck(att).compact
    if vals.length > 0
      (vals.inject(0){ |sum, el| sum + el }/vals.length.to_f).round(decimals)
    else
      nil
    end
  end

  def abv
    if original_grav && final_grav
      ((76.08*(original_grav - final_grav)/(1.775 - original_grav))*(final_grav / 0.794))
    else
      nil
    end
  end

  def exp_abv
    o_grav = exp(:original_grav)
    f_grav = exp(:final_grav)
    if o_grav && f_grav
      ((76.08*(o_grav - f_grav)/(1.775 - o_grav))*(f_grav / 0.794))
    else
      nil
    end
  end
end
