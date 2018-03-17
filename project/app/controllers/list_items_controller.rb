class ListItemsController < ApplicationController
  
  def create
    @list = List.find(params[:list_id])
    @item = ListItem.new( list:         @list.id,
                          description:  params[:list_item][:description],
                          comments:     params[:list_item][:comments],
                          site_link:    params[:list_item][:site_link],
                          quantity:     params[:list_item][:quantity])
    if @list.save
      flash[:success] = 'Item created'
      redirect_to '/users/show'
    else
      flash.now[:notice] = 'Could not create item. Please verify all fields filled in.'
      render '/users/show'
    end
  end

  def destroy
    item = ListItem.find(params[:id])
    item.destroy
    flash[:success] = 'List Item Deleted'
    @list = List.find(params[:list_id])
  end
end
