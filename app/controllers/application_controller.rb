class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :total_users
  before_action :total_maps
  include SessionsHelper

  private
	  def total_users
	  	@total_users = User.count
	  end

	  def total_maps
	  	@total_maps = Map.all
	  end
end
