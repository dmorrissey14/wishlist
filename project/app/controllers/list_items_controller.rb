# Controller for accessing and manipulating List Items.
class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:List_Item][:list_id])
    @item = ListItem.new(list_id:      @list.id,
                         description:  params[:List_Item][:Description],
                         comments:     params[:List_Item][:Comments],
                         site_link:    params[:List_Item][:Link],
                         quantity:     params[:List_Item][:Quantity])
    begin
      Integer(params[:List_Item][:Quantity])
      if @item.save

        flash[:success] = 'Item Created!'
        redirect_to '/lists'
      else
        flash[:notice] = 'Could not create item. Please'\
                          ' verify all fields filled in'\
                          ' correctly.'
        redirect_to request.referrer
      end
    rescue
      flash[:notice] = 'Could not create item. Please'\
                       ' verify all fields filled in'\
                       ' correctly.'
      redirect_to request.referrer
      @item.destroy
    end
  end

  def new
    @list = List.find(params[:id])
  end

  def destroy
    item = ListItem.find(params[:id])
    item.destroy
    flash[:warning] = 'Item Deleted'
    redirect_to request.referrer
  end
end
