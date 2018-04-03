# Base class from which all controllers inherit.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :confirm_logged_in

  private

  def confirm_logged_in
    redirect_to('/users/new') unless logged_in?
  end
end
