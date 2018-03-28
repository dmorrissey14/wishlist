class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:List_Item][:list_id])
    @item = ListItem.new( list_id:         @list.id,
                          description:  params[:List_Item][:Description],
                          comments:     params[:List_Item][:Comments],
                          site_link:    params[:List_Item][:Link],
                          quantity:     params[:List_Item][:Quantity])
    if @item.save
      flash[:success] = 'Item created'
      redirect_to '/lists'
    else
      flash.now[:notice] = 'Could not create item. Please verify all fields filled in.'
      render '/lists'
    end
  end

  def new
    @list = List.find(params[:id])
  end

  def destroy
    item = ListItem.find(params[:id])
    item.destroy
    flash[:success] = 'List Item Deleted'
    redirect_to '/lists'
  end
end
