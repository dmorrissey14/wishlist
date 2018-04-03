# Controller for accessing and manipulating Users.
class UsersController < ApplicationController
  skip_before_action :confirm_logged_in, only: %i[new create]

  def new; end

  def show
    if logged_in?
      @user = current_user
    else
      redirect_to '/login'
    end
  end

  def create
    @user = User.new(email: params[:session][:email],
                     password: params[:session][:password],
                     first_name: params[:session][:first_name],
                     last_name: params[:session][:last_name])

    if (params[:session][:password_confirmation] == @user.password) &&
       @user.save
      log_in @user # calls log_in method in helper
      redirect_to '/lists' # goes to show action for this user
    else
      # failed to create user
      flash.now[:notice] = 'Could not create new user. Make sure you entered'\
                           ' your credentials correctly and your password is'\
                           ' at least eight characters including upper case,'\
                           ' lower case, and numbers.'
      render 'new' # render registration page
    end
  end
end
