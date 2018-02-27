class UsersController < ApplicationController
  
  puts "hit user controller"
  def new
    #@user = User.new
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
      log_in @user #calls log_in method in helper
      flash[:success] = "Registered user"
      
      redirect_to @user #goes to show action for this user
    else
      #failed to create user
      render 'new' #render registration page
    end
  end

  #private

  #  def user_params
  #    params.require(:email).permit(:first_name, :last_name, :password, :password_confirmation)
  #  end

end
