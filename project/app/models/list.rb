# Represents a list of items for an arbitrary purpose.
class List < ApplicationRecord
  # Alias attributes
  alias_attribute :owner, :user

  # Associations
  belongs_to :user
  has_and_belongs_to_many :groups
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
    return true if user.id == owner.id
    groups.each do |g|
      return true if g.users.include?(user)
    end
    false
  end
end
