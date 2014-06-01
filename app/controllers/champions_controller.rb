class ChampionsController < ApplicationController
	# Under Construction
	# Will handle catching champions
	before_action :signed_in_user

	@table_champion = @champion.table_champion

	def create
		@champion = current_user.champions.build(champion_params)
		if @champion.save
			# Change this to the champion name
			flash[:success] = "You caught a #{@champion.table_champion_id}!"
			# Change this to the map that you came from
			redirect_to root_url
		else
			# Redirect somewhere else
			render root_url
		end
	end

	private
		def champion_params
			params.require(:champion)
		end
end
