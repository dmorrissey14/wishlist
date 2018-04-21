# Controller for accessing and manipulating List Items.
class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:List_Item][:list_id])
    @item = ListItem.new(list_id:      @list.id,
                         description:  params[:List_Item][:Description],
                         comments:     params[:List_Item][:Comments],
                         site_link:    params[:List_Item][:Site_Link],
                         image_link:   params[:List_Item][:Image_Link],
                         quantity:     params[:List_Item][:Quantity])

    warning_base = 'Could not create item.'

    warning_quantity = ' Please verify the Quantity is'\
                       ' filled in correctly.'

    warning_item_name = ' Please verify Item Name is'\
                        ' filled in correctly.'

    warning_image_url = ' The Image URL field may be incompatible.'\
                        ' Make sure it ends with .jpg, .png or .apng'\
                        ' and is a valid http or https URL.'

    warning_site_url = ' The Site URL field may be invalid.'\
                       ' Make sure it is a valid http or https URL.'

    error_msg = ''

    # Validate Quantity
    begin
      Integer(params[:List_Item][:Quantity])
    rescue TypeError, ArgumentError
      error_msg += warning_quantity
    end

    # Validate Description (Item Name)
    error_msg += warning_item_name if params[:List_Item][:Description].empty?

    # Validate Image URL
    error_msg += warning_image_url unless valid_image_url?

    # Validate Site URL
    error_msg += warning_site_url unless valid_site_url?

    # Only save the item if there were no validation errors
    if error_msg.empty? && @item.save
      flash[:success] = 'Item Created!'
      redirect_to '/lists'
    else
      @item.destroy
      flash[:notice] = warning_base + error_msg
      redirect_to request.referrer
    end
  end

  def new
    @list = List.find(params[:id])
  end

  def destroy
    item = ListItem.find(params[:id])
    if item.list.user_id != current_user.id
      item.purchased = if item.purchased?
                         0
                       else
                         1
                       end
      item.save
    else
      item.destroy
      flash[:warning] = 'Item Deleted'
    end
    redirect_to request.referrer
  end

  private

  def valid_image_url?
    valid_site_url? &&
      (params[:List_Item][:Image_Link]['.jpg'] ||
      params[:List_Item][:Image_Link]['.png'] ||
      params[:List_Item][:Image_Link]['.apng'])
  end

  def valid_site_url?
    !params[:List_Item][:Site_Link].empty? &&
      (params[:List_Item][:Image_Link]['http://'] ||
      params[:List_Item][:Image_Link]['https://'])
  end
end
