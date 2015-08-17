class User < ActiveRecord::Base

  validates :username, :password_digest, :session_token, :city, :state, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :username, format: { with: /\w+/,
    message: "must contain only letters, digits, and underscores"}
  validate :has_valid_city
  validate :has_valid_state

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user && user.has_password?(password)
    user
  end

  def self.pick_random(num)
    ids = User.pluck(:id).sample(num)
    users = User.find(ids)
    users
  end

  # def self.find_or_create_by_auth_hash(auth_hash)
  #   user = User.find_by(
  #     provider: auth_hash[:provider],
  #     uid: auth_hash[:uid]
  #   )
  #
  #   unless user
  #     user = User.create!(
  #       provider: auth_hash[:provider],
  #       uid: auth_hash[:uid],
  #       username: auth_hash[:info][:nickname],
  #       password: SecureRandom::urlsafe_base64
  #     )
  #   end
  #
  #   user
  # end

  def self.generate_session_token
    new_token = SecureRandom.urlsafe_base64(16)
    old_tokens = User.pluck(:session_token)
    until !old_tokens.include?(new_token)
      new_token = SecureRandom.urlsafe_base64(16)
    end
    new_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def has_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  # private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def has_valid_state
    unless CS.states(:US).keys.map{ |el| el.to_s }.include?(self.state)
      errors.add(:state, "state invalid")
    end
  end

  def has_valid_city
    unless self.state && CS.cities(self.state.to_sym, :US).include?(self.city)
      errors.add(:city, "city invalid")
    end
  end

end
