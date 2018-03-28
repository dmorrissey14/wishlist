class SessionsController < ApplicationController
  skip_before_action :confirm_logged_in, only: [:new, :create]
  
  def new
  end

  def create
    hashed_password = User.digest(params[:session][:password])
    hashed_email = User.digest(params[:session][:email])

    user = User.find_by(email_hash: hashed_email)
    if user && (user[:password_hash] == hashed_password)
      log_in user
      remember user
      redirect_to '/users/show'
    else
      flash.now[:notice] = "Failed login. Make sure you entered your credentials correctly."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
