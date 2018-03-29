# Controller for accessing and manipulating Lists.
class ListsController < ApplicationController
  def create
    @list = List.new(owner:        current_user,
                     name:         params[:list][:name],
                     description:  params[:list][:description])
    if @list.save
      flash[:success] = 'List Created!'
      redirect_to '/users/show'
    else
      flash.now[:notice] = 'Could not create list. Please verify it has a'\
                           ' name and description.'
      render 'new'
    end
  end

  def destroy
    list = List.find(params[:id])
    return if list.nil?
    list.destroy
    flash[:success] = 'List Deleted'
    redirect_to '/lists'
  end

  def view_list
    @list = List.find(params[:id])
    @items = @list.list_items
    redirect_to '/list_items', @items
  end

  def show
    @list = List.find(params[:id])
  end
end
