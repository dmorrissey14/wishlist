# Controller for accessing and manipulating Sessions.
class SessionsController < ApplicationController
  skip_before_action :confirm_logged_in, only: %i[new create]

  def new; end

  def create
    User.digest(params[:session][:password])
    User.digest(params[:session][:email])

    email = params[:session][:email]
    password = params[:session][:password]

    User.find_each do |record|
      if BCrypt::Password.new(record[:email_hash]).is_password?(email)
        @user = record
      end
    end

    match = BCrypt::Password.new(@user[:password_hash]).is_password?(password)

    if match
      log_in @user
      remember @user
      redirect_to '/lists'
    else
      flash.now[:notice] = 'Failed login. Make sure you entered your'\
                           ' credentials correctly.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
