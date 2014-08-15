class ChallengersController < ApplicationController
	before_action :signed_in_user
	def list
		
	end

	def spawn_challenger
		@challenger = current_user.challengers.build(spawn_params)
		if @challenger.save
			flash[:success] = "Challenger Spirit id:#{@challenger.id} Challenger:#{@challenger.table_challenger.name} Champion: #{@challenger.table_challenger.table_champion.name}"
			redirect_to current_user
		else
			flash[:danger] = "Did not spawn the champion"
			redirect_to current_user
		end		
	end

	def spawn_page
		@challenger = current_user.champions.build		
	end
	private

		def spawn_params
			params.require(:challenger).permit(:table_challenger_id)
		end
end
