class TableChampionsController < ApplicationController
	before_action :signed_in_user
	
	def index
		@table_champions = TableChampion.where.not(id: 999)
		@table_champions.sort_by! { |champ| champ.id }
	end

	def show
		@table_champion = TableChampion.find(params[:id])
		@f_role = Role.where(name: @table_champion.f_role).first
		@s_role = Role.where(name: @table_champion.s_role).first
	end
end
