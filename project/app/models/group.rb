# Represents a group of users.
class Group < ApplicationRecord
  # Associations
  has_and_belongs_to_many :users
  has_and_belongs_to_many :lists

  attr_accessor :user_id

  # Validations
  validates :name, presence: true
end
