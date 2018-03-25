class GroupsController < ApplicationController


  def create
    @group = Group.new( name:      params[:name],
                      description:  params[:description])

    if @group.save
      flash[:success] = 'Group Created!'
      redirect_to '/groups/', @group.id
    else
      flash.now[:notice] = 'Could not create group. Please verify it has a name and description.'
      render 'new'
    end
  end

  def destroy
    group = Group.find(params[:id])
    unless group.nil?
      group.destroy
      flash[:success] = 'Group Deleted'
      redirect_to '/users/show'
    end
  end

  def show
    if logged_in?
      @user = current_user
    else
      redirect_to '/login'
    end
    @group = Group.find(params[:id])
  end
end
