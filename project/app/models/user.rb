# Represents a single application user.
class User < ApplicationRecord
  # Accessors
  attr_accessor :remember_token
  attr_reader :email, :password

  def email=(value)
    @email = value
    write_attribute(:email_hash, User.digest(value))
  end

  def password=(value)
    @password = value
    write_attribute(:password_hash, User.digest(value))
  end

  # Associations
  has_and_belongs_to_many :groups
  has_many :lists

  # Validations
  validates :email_hash, presence: true,
                         uniqueness: { case_sensitive: false }
  validates :password_hash, presence: true
  validates :email,
            presence: true,
            length: { maximum: 31 },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password,
            presence: true,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/ }
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Callbacks
  before_destroy :delete_owned_lists

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  # Deletes all lists owned by the user.
  def delete_owned_lists
    lists.each(&:destroy)
  end

end
