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
      flash[:notice] = 'Could not create group.'\
                       ' Please verify it has a name.'
      render 'new'
    end
  end

  def show
    if logged_in?
      @user = current_user
      @cache = UserSuggestionCache.new(@user)
    else
      redirect_to '/login'
    end
  end

  def update
    group = Group.find(params[:id])
    return if group.nil?
    if params[:group][:user_id].nil?
      add_list_to_group(group)
    else
      add_user_to_group(group)
    end
    redirect_to '/groups'
  end

  def destroy
    group = Group.find(params[:id])
    return if group.nil?
    group.destroy
    flash[:warning] = 'Group Deleted'
    redirect_to '/groups'
  end

  private

  def add_list_to_group(group)
    list = List.find_by id: params[:list][:id]
    unless list.nil?
      return if group.lists.include?(list)
      group.lists.push(list)
      return if group.save
    end
    flash.now[:notice] = 'Could not update lists'
  end

  def add_user_to_group(group)
    user = infer_user_from_string(params[:group][:user_id])
    return if user.nil?
    return if group.users.include?(user)
    group.users.push(user)
    group.save
  end

  def infer_user_from_string(user_string)
    return nil if user_string.to_s.empty?

    # Is user_string an email?
    if user_string.include?('@')
      email = user_string.downcase
      User.find_each do |record|
        if BCrypt::Password.new(record[:email_hash]).is_password?(email)
          return record
        end
      end
      flash[:notice] = 'Could not find user with provided email address.'
      return nil
    end

    # Attempt to locate the user ID in the string and use that.
    # Assuming string format is "user_name (user_id)"
    start_index = user_string.index('(')
    end_index = user_string.index(')')
    return nil if start_index.nil? || end_index.nil?
    User.find_by id: user_string.slice((start_index + 1)..(end_index + 1))
  end
end
