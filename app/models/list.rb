# Represents a list of items for an arbitrary purpose.
class List < ApplicationRecord
  # Alias attributes
  alias_attribute :owner, :user
  alias_attribute :viewers, :group

  # Associations
  belongs_to :user
  belongs_to :group, dependent: :destroy
  has_many :list_items, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :user, presence: true
  validates :group, presence: true

  # Callbacks
  after_initialize :create_viewers_group

  # Returns whether or not the provided user is the list owner.
  def owner?(user)
    user.id == owner.id
  end

  def self.create(name, description)
    list = List.new(name, description)
    list.save
    list
  end

  # Returns whether or not the provided user can view the list.
  def viewer?(user)
    return true unless user.id != owner.id
    viewers.users.includes(user.id)
  end

  private

  # Creates the group containing all users that can view the list.
  def create_viewers_group
    return false unless group.nil?
    group_name = 'list_viewers_group'
    self.group = Group.create(name: group_name)
  end
end
