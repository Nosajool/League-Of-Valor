class TableChampionsController < ApplicationController
	before_action :signed_in_user
	
	def index
		@table_champions = TableChampion.where.not(id: 999)
	end
end
