class ChallengersController < ApplicationController
	before_action :signed_in_user
	before_action :admin_user, only: [:spawn, :spawn_page]
	
	def list
		@challengers = current_user.challengers
	end

	def spawn
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
		@challenger = current_user.challengers.build		
	end

	private

		def spawn_params
			params.require(:challenger).permit(:table_challenger_id)
		end
end
