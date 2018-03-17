# Represents a list of items for an arbitrary purpose.
class List < ApplicationRecord
  # Alias attributes
  alias_attribute :owner, :user

  # Associations
  belongs_to :user
  has_many :list_items, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :user, presence: true

  # Returns whether or not the provided user is the list owner.
  def owner?(user)
    user.id == owner.id
  end

  # Returns whether or not the provided user can view the list.
  def viewer?(user)
    return true unless user.id != owner.id
    viewers.users.include?(user)
  end
end
