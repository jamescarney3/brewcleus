class UserFollow < ActiveRecord::Base

  validates :follower_id, :followed_id, presence: true
  validate :is_not_already_following

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

  private

  def is_not_already_following
    if User.find(self.follower_id).user_follow_followed.pluck("followed_id").include?(self.followed_id)
      errors.add(:followed_id, "User is already following this user")
    end
  end

end
