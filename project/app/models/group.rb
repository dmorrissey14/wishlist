# Represents a group of users.
class Group < ApplicationRecord
  # Associations
  has_and_belongs_to_many :users

  # Validations
  validates :name, presence: true

  # Callbacks
  before_destroy :check_for_lists

  private

  # Returns whether or not the group is associated with an existing list.
  def check_for_lists
    list.nil?
  end
end
