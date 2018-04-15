# Controller for accessing and manipulating Lists.
class ListsController < ApplicationController
  def create
    @list = List.new(owner:        current_user,
                     name:         params[:list][:name],
                     description:  params[:list][:description])
    
    if @list.save
      flash[:success] = 'List Created!'
      redirect_to '/lists'
    else
      flash.now[:notice] = 'Could not create list. Please verify it has a name'
      render 'new'
    end
  end
  
  def destroy
    list = List.find(params[:id])
    return if list.nil?
    list.destroy
    flash[:warning] = 'List Deleted'
    redirect_to '/lists'
  end

  def view_list
    @list = List.find(params[:id])
    return if @list.nil?
    redirect_to '/lists' unless @list.viewer?(current_user)
    @items = @list.list_items
    redirect_to '/list_items', @items
  end

  def show
    @list = List.find(params[:id])
    return if @list.nil?
    redirect_to '/lists' unless @list.viewer?(current_user)
  end
end
