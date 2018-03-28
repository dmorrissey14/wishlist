class StaticController < ApplicationController
  skip_before_action :confirm_logged_in, only: [:home, :create]
  
  def home
  end

  def login
  end
  
end
