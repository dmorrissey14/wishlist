# Represents a single application user.
class User < ApplicationRecord
  # Accessors
  attr_accessor :remember_token
  attr_reader :email, :password

  def email=(value)
    value = value.downcase
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
  validates :first_name,
            presence: true,
            format: { with: /\A[A-Za-z0-9.&]*\z/ } # Don't allow special chars
  validates :last_name,
            presence: true,
            format: { with: /\A[A-Za-z0-9.&]*\z/ } # Don't allow special chars

  # Callbacks
  before_destroy :delete_owned_lists

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:session_token_hash, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if session_token_hash.nil?
    BCrypt::Password.new(session_token_hash).is_password?(remember_token)
  end

  def forget
    update_attribute(:session_token_hash, nil)
  end

  # Returns the full name of the user.
  def full_name
    first_name + ' ' + last_name
  end

  # Returns a display string containing the user's full name
  # and user ID.
  def display_string
    full_name + ' (' + id.to_s + ')'
  end

  private

  # Deletes all lists owned by the user.
  def delete_owned_lists
    lists.each(&:destroy)
  end
end
