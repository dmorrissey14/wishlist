require 'user_suggestion_cache'

# Controller for accessing and manipulating Groups.
class GroupsController < ApplicationController
  def create
    @group = Group.new(name:          params[:group][:name],
                       description:   params[:group][:description])

    if @group.save
      flash[:success] = 'Group Created!'
      @group.users.push(User.find(current_user.id))
      redirect_to '/groups'
    else
      flash.now[:notice] = 'Could not create group.'\
                           ' Please verify it has a name.'
      render 'new'
    end
  end

  def destroy
    group = Group.find(params[:id])
    return if group.nil?
    group.destroy
    flash[:success] = 'Group Deleted'
    redirect_to '/groups'
  end

  def show
    if logged_in?
      @user = current_user
      @cache = UserSuggestionCache.new(@user)
    else
      redirect_to '/login'
    end
  end

  # Need to do some error checks here, just trying to get functionality
  def update
    group = Group.find(params[:id])
    if params[:group][:user_id].nil?
      list = List.find(params[:list][:id])
      group.lists.push(list)
    else
      user = User.find(params[:group][:user_id])
      group.users.push(user)
    end
    group.save
    redirect_to '/groups'
  end
end
