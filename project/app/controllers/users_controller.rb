class UsersController < ApplicationController
  def new
  end

  def show
    if logged_in?
      @user = current_user
    else
      redirect_to '/login'
    end
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    password_confirmation = params[:session][:password_confirmation]
    first_name = params[:session][:first_name]
    last_name = params[:session][:last_name]

    @user = User.new(email: email, password: password, first_name: first_name, last_name: last_name)

    if @user.save && (password_confirmation == password)
      log_in @user # calls log_in method in helper
      redirect_to '/users/show' # goes to show action for this user
    else
      # failed to create user
      flash.now[:notice] = "Could not create new user. Make sure you entered your credentials correctly and your password is at least six characters."
      render 'new' # render registration page
    end
  end
end
