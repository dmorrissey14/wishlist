
class ListsController < ApplicationController
    #before_action :logged_in_user, only: [:create, :destroy]
    #before_action :correct_user,   only: :destroy
    
    def create

      @user = User.find_by_id(1)

      #write_attribute(:user_id, @user.id)
      #write_attribute(:group_id, value)

      #if @list.save
      #  flash[:success] = "List Created!"
      #else
      #  @feed_items = []
      #end
      #render 'user/show'
    end

    def save
      @list = List.new
      user = User.find_by_id(1)
      @list.user_id = user.id
      @list.name = params[:lists][:name]
      @list.description = params[:lists][:description]
      #list.create(params[:name],params[:description])
      if @list.save
        flash[:success] = "List Created!"
      else
        @feed_items = []
      end
    end

    def list_items
      
      id = params[:id]
      @list = List.find_by_id(id)
      listitem = ListItem.new
      @items = listitem.find(id)

    end

    def create_item
      
      @list_id = params[:list_id]
      list_id = params[:list_id]
      list = List.find_by_id(list_id)
      @list = List.find_by_id(@list_id)

    end

    def save_item
      templist = ListItem.new
      ListItem.create(params)

    end

    def get_list
      id = params[:id]
      list = List.find_by_id(id)
      @list = list
      redirect_to controller: 'lists', action: 'list_items', id: @list

    end

    def destroylist
      id = params[:id]
      list = List.find_by_id(id)
      list.destroy
      flash[:success] = "List Deleted"
    end

    def destroyitem
      id = params[:id]
      @list_id = params[:list_id]
      listitem = ListItem.new
      @items = listitem.destroyitem(id)
      flash[:success] = "List Deleted"
    end
  
  end
  
  