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
  def self.create(params)

    @list = List.find(params[:Item][:listId])
    @newListItem = ListItem.new
    #newListItem = ListItem.create(description: params[:Item][:Description], list: @list)
    @newListItem.description = params[:Item][:Description]
    @newListItem.list_id = params[:Item][:listId]
    @newListItem.comments = params[:Item][:Comments]
    @newListItem.site_link = params[:Item][:Link]
    @newListItem.quantity = params[:Item][:Quantity]
    @newListItem.purchased = 0
    @newListItem.save 
    @newListItem
  end
  def purchased?
    quantity == purchased
  end

  def find(listid)
    list_items = ListItem.connection.select_all("SELECT * FROM list_items WHERE list_id = #{listid}")
    return list_items
  end

  def destroyitem(id)
    list_items = ListItem.connection.select_all("DELETE FROM list_items WHERE id = #{id}")
  end
end
