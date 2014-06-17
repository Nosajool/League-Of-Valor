class MapsController < ApplicationController
	before_action :signed_in_user
  	def index
  		@maps = Map.all
  	end

  	def show
  		@map = Map.find(params[:id])
  	end
end
