 module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.email_hash
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(email_hash: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def hash_email(email_address)
    email_address = email_address.downcase
    hashed_email_address = BCrypt::Password.create(email_address)
  end
end 