class Batch < ActiveRecord::Base

  validates :user_id, :recipe_id, :brew_date, :rating, presence: true
  validate :rating_is_in_valid_range

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

  def rating_is_in_valid_range
    unless self.rating >= 0 && self.rating <= 5
      errors.add(:rating, "Rating outside of valid range")
    end
  end

end
