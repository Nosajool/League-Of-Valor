class TableChampionsController < ApplicationController
	before_action :signed_in_user, only: [:index]	
	def index
		@table_champions = TableChampion.all
	end
end
