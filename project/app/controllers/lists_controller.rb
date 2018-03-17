
class ListsController < ApplicationController
  # before_action :logged_in_user, only: [:create, :destroy]
  # before_action :correct_user,   only: :destroy

  def create
    @list = List.new( owner:      current_user,
                      name:         params[:list][:name],
                      description:  params[:list][:description])
                      
    if @list.save
      flash[:success] = 'List Created!'
      redirect_to '/users/show'
    else
      flash.now[:notice] = 'Could not create list. Please verify it has a name and description.'
      render 'new'
    end
  end

  def list_items
    @list = List.find(params[:id])
    @items = @list.list_items
  end

  def create_item
    @list = List.find(params[:list_id])
  end

  def save_item
    item = ListItem.new
    item.list = List.find(params[:Item][:listId])
    item.description = params[:Item][:Description]
    item.comments = params[:Item][:Comments]
    item.site_link = params[:Item][:Link]
    item.quantity = params[:Item][:Quantity]
    item.save
  end

  def get_list
    @list = List.find(params[:id])
    redirect_to controller: 'lists', action: 'list_items', id: @list.id
  end

  def destroylist
    list = List.find(params[:id])
    unless list.nil?
      list.destroy
      flash[:success] = 'List Deleted'
    end
  end

  def destroyitem
    item = ListItem.find(params[:id])
    item.destroy
    flash[:success] = 'List Item Deleted'
    @list = List.find(params[:list_id])
  end
end
