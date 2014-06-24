class TableChampionsController < ApplicationController
	before_action :signed_in_user
	
	def index
		@table_champions = TableChampion.where.not(id: 999)
		@table_champions.sort_by! { |champ| champ.id }
	end

	def show
		@table_champion = TableChampion.find(params[:id])
	end
end
