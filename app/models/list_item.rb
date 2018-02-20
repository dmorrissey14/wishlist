# Represents a single item contained in a wish list.
class ListItem < ApplicationRecord
  # Associations
  belongs_to :list

  # Validations
  validates :list, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :purchased, presence: true

  # Returns whether or not the requested quantity  of the list item
  # has been purchased.
  def purchased?
    quantity == purchased
  end
end
