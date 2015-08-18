class Recipe < ActiveRecord::Base

  validates :author_id, :name, :style, :description, presence: true
  validates :name, uniqueness: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
end
