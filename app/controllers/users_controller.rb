class UsersController < ApplicationController
  def new
  end

  def show
    if logged_in?
      @user = current_user
    else
      redirect_to 'session/new'
    end
  end

  def create
    hashed_password = calculate_hash(params[:session][:password])
    hashed_email = calculate_hash(params[:session][:email])

    @user = User.new(hashed_email, hashed_password)
    if @user.save
      log_in @user # calls log_in method in helper
      redirect_to '/users/show' # goes to show action for this user
    else
      # failed to create user
      render 'new' # render registration page
    end
  end
end
