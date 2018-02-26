class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(1)
    @list = @user.lists
  end
end
