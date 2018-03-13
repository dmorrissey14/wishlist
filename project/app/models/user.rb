# Represents a single application user.
class User < ApplicationRecord
  # Accessors
  attr_reader :email, :password

  def email=(value)
    @email = value
    write_attribute(:email_hash, calculate_hash(value))
  end

  def password=(value)
    @password = value
    write_attribute(:password_hash, calculate_hash(value))
  end

  # Associations
  has_and_belongs_to_many :groups
  has_many :lists

  # Validations
  validates :email_hash, presence: true,
                         uniqueness: { case_sensitive: false }
  validates :password_hash, presence: true
  validates :email, presence: true,
                    length: { maximum: 31 },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: 6..20

  # Callbacks
  before_destroy :delete_owned_lists

  # Performs additional initialization when creating a new instance
  # of the User class. Required to allow for the instance to be
  # created using content not stored in the database.
  def initialize(email, password)
    super()
    @email = email
    write_attribute(:email_hash, calculate_hash(email))
    @password = password
    write_attribute(:password_hash, calculate_hash(password))
  end

  # Override of User.create to allow for the instance to be created
  # using content not stored in the database.
  def self.create(email, password)
    user = User.new(email, password)
    user.save
    user
  end

  # Creates an anonymous user instance for an unregistered user.
  # Cannot be saved to the database as provided.
  def self.new_anonymous_user
    User.new('', '')
  end

  private

  # Deletes all lists owned by the user.
  def delete_owned_lists
    lists.each(&:destroy)
  end

  def calculate_hash(input)
    hash = Digest::SHA512.hexdigest(input)
    hash[0..31]
  end
end
