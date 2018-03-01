class SessionsController < ApplicationController
  def new
  end

  def create
    hashed_password = calculate_hash(params[:session][:password])
    hashed_email = calculate_hash(params[:session][:email])
    user = User.find_by(email_hash: hashed_email)

    if user && (user[:password_hash] == hashed_password)
      log_in user
      redirect_to '/users/show'
    else
      flash.now[:notice] = "Failed login. Make sure you entered your credentials correctly."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
