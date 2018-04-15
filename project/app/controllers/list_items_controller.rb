# Controller for accessing and manipulating List Items.
class ListItemsController < ApplicationController
  def create
    @list = List.find(params[:List_Item][:list_id])
    @item = ListItem.new(list_id:      @list.id,
                         description:  params[:List_Item][:Description],
                         comments:     params[:List_Item][:Comments],
                         site_link:    params[:List_Item][:Link],
                         quantity:     params[:List_Item][:Quantity])
    
    warning1 = 'Could not create item. Please'\
              ' verify Item Name and Quantity'\
              ' fields are filled in correctly.'

    warning2 = 'Could not create item. Please'\
              ' verify Item Name field is'\
              ' filled in correctly.'

    warning3 = 'Could not create item. Quantity'\
              ' Value field is invalid.'

    warning4 = 'Could not create item. Please'\
              ' verify Item Name and Quantity'\
              ' fields are filled in correctly.'\
              ' Image URL field may be incompatible.'\
              ' Make sure image URL ends with .jpg,'\
              ' .png or .apng and is a valid http or'\
              ' https URL.'

    warning5 = 'Could not create item. Please'\
              ' verify Quantity field is filled in'\
              ' correctly. Image URL field may be'\
              ' incompatible. Make sure image URL ends'\
              ' with .jpg, .png or .apng and is a'\
              ' valid http or https URL.'

    warning6 = 'Could not create item. Please'\
              ' verify Item Name field is filled in'\
              ' correctly. Image URL field may be'\
              ' incompatible. Make sure image URL ends'\
              ' with .jpg, .png or .apng and is a'\
              ' valid http or https URL.'

    warning7 = 'Could not create item. Image URL field'\
              ' may be incompatible. Make sure image URL ends'\
              ' with .jpg, .png or .apng and is a valid http or'\
              ' https URL.'

    # Check Both crucial quantities and then check rest under those
    # Quantity messed up
    begin
      Integer(params[:List_Item][:Quantity])
    rescue
      if params[:List_Item][:Description].empty?
        if !params[:List_Item][:Link].empty?  && !((params[:List_Item][:Link][".jpg"] || params[:List_Item][:Link][".png"] || params[:List_Item][:Link][".apng"]) && (params[:List_Item][:Link]["http://"] || params[:List_Item][:Link]["https://"]))
          flash[:notice] = warning4
        else
          flash[:notice] = warning1
        end
      else
        if !params[:List_Item][:Link].empty?  && !((params[:List_Item][:Link][".jpg"] || params[:List_Item][:Link][".png"] || params[:List_Item][:Link][".apng"]) && (params[:List_Item][:Link]["http://"] || params[:List_Item][:Link]["https://"]))
          flash[:notice] = warning5
        else
          flash[:notice] = warning3
        end
      end
      @item.destroy
      redirect_to request.referrer
      return
    end

    # Description messed up
    if params[:List_Item][:Description].empty?
      if !params[:List_Item][:Link].empty?  && !((params[:List_Item][:Link][".jpg"] || params[:List_Item][:Link][".png"] || params[:List_Item][:Link][".apng"]) && (params[:List_Item][:Link]["http://"] || params[:List_Item][:Link]["https://"]))
        flash[:notice] = warning6
      else
        flash[:notice] = warning2
      end
      @item.destroy
      redirect_to request.referrer
      return
    end

    # Image URL is filled in but messed up
    if !params[:List_Item][:Link].empty? && !((params[:List_Item][:Link][".jpg"] || params[:List_Item][:Link][".png"] || params[:List_Item][:Link][".apng"]) && (params[:List_Item][:Link]["http://"] || params[:List_Item][:Link]["https://"]))
      flash[:notice] = warning7
      @item.destroy
      redirect_to request.referrer
      return
    end

    if @item.save
      flash[:success] = 'Item Created!'
      redirect_to '/lists'
      return
    else
      flash[:notice] = warning1
      redirect_to request.referrer
      return
    end
  end

  def new
    @list = List.find(params[:id])
  end

  def destroy
    item = ListItem.find(params[:id])
    if item.list.user_id != current_user.id
      if item.purchased?
        item.purchased = 0
      else
        item.purchased = 1
      end
      item.save
    else
      item.destroy
      flash[:warning] = 'Item Deleted'
    end
    redirect_to request.referrer
  end
end
