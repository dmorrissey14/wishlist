class SessionsController < ApplicationController
  def new
  end

  def create
    hashed_password = calculate_hash(params[:session][:password])
    hashed_email = calculate_hash(params[:session][:email])
    user = User.find_by(email_hash: hashed_email)

    if user
      puts "found user"
    else 
      puts "did not find user"
    end

    if user && (user[:password_hash] == hashed_password)
      log_in user
      #successful authentication, render user page
      puts "login success"
      redirect_to user
    else
      #failed authentication, render the login page
      flash.now[:danger] = 'Invalid email/password combination'
      puts "login failed digest:"
      puts hashed_password
      puts "db pw hash:"
      puts user[:password_hash]
      render 'new'
    end

  end

  def destroy
    log_out
    redirect_to root_url
  end
end