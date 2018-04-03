# Controller for accessing and manipulating static actions.
class StaticController < ApplicationController
  skip_before_action :confirm_logged_in, only: %i[home create]

  def home; end

  def login; end
end
