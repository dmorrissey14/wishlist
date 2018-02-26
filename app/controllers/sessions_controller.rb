class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_hash: hash_email(params[:session][:email]))
    if user && user.authenticate(params[:session][:password])
      log_in user
      #successful authentication, render user page
      #redirect_to user
    else
      #failed authentication, render the login page
      #render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end