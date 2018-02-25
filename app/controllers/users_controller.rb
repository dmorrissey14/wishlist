class UsersController < ApplicationController
  def new
  end

  def show
    #@user = User.find(params[:id])
    @user = User.find_by_id(1)
    @list = @user.list
  end
end
