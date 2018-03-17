# Represents a group of users.
class Group < ApplicationRecord
  # Associations
  has_and_belongs_to_many :users

  # Validations
  validates :name, presence: true
end
