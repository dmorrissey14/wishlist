
class ListsController < ApplicationController
  # before_action :logged_in_user, only: [:create, :destroy]
  # before_action :correct_user,   only: :destroy

  def create
    @user = User.find(1)

    # write_attribute(:user_id, @user.id)
    # write_attribute(:group_id, value)

    # if @list.save
    #   flash[:success] = "List Created!"
    # else
    #   @feed_items = []
    # end
    # render 'user/show'
  end

  def save
    @list = List.new
    user = User.find(1)
    @list.user = user
    @list.name = params[:lists][:name]
    @list.description = params[:lists][:description]
    if @list.save
      flash[:success] = 'List Created!'
    else
      @feed_items = []
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
