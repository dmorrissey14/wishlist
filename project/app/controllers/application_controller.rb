class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :confirm_logged_in

  private

  def confirm_logged_in
    unless logged_in?
      redirect_to('/users/new')
    end
  end

end
