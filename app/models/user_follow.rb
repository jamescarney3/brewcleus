class UserFollow < ActiveRecord::Base

  validates :follower_id, :followed_id, presence: true

  belongs_to(
    :follower,
    class_name: "User",
    foreign_key: :follower_id,
    primary_key: :id
  )

  belongs_to(
    :followed,
    class_name: "User",
    foreign_key: :followed_id,
    primary_key: :id
  )

end
