class UsersController < ApplicationController
  def new
    @user = User.new_anonymous_user
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    hashed_password = calculate_hash(params[:session][:password])
    hashed_email = calculate_hash(params[:session][:email])

    @user = User.new(hashed_email, hashed_password)
    if @user.save
      log_in @user # calls log_in method in helper
      redirect_to @user # goes to show action for this user
    else
      # failed to create user
      render 'new' # render registration page
    end
  end
end
