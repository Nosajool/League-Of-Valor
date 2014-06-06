class ChampionsController < ApplicationController
	# Under Construction
	# Will handle catching champions
	before_action :signed_in_user

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

	def edit
		# Can't switch ppl that are in your roster...(Like can't switch from position 1 to 5)
		@roster = current_user.champions.where.not("position = '0'")
		@roster.sort! do |a,b|
			a.position <=> b.position
		end
		@non_roster = current_user.champions.where("position = '0'")
	end

	def bench
		@bench = current_user.champions.where("position = '0'")
	end
	
	def change_roster
		# Can't swap unless you have 5 champs already...
		old_position = Champion.find(params[:old_id]).position
		new_position = params[:position].to_i
		# Check that both id's exist
		if Champion.where(:id => params[:old_id]).blank? || Champion.where(:id => params[:new_id]).blank?
			flash[:danger] = "Champion doesn't exist"
			redirect_to roster_path
			# Ensure that both champions are the current user's
		elsif Champion.find(params[:old_id]).user != current_user || Champion.find(params[:new_id]).user != current_user
			flash[:danger] = "You can't change someone else's roster"
			redirect_to roster_path
		elsif old_position != new_position
			# Ensure that there is a champion at the old position
			flash[:danger] = "The champion that you are swapping out is invalid"
			redirect_to roster_path
		else
			@old_champ = Champion.find(params[:old_id])
			@new_champ = Champion.find(params[:new_id])
			@old_champ.position = 0
			@new_champ.position = params[:position]
			@old_champ.save
			@new_champ.save
			flash[:success] = "Roster Positions updated"
			redirect_to roster_path
		end

		
	end

	private
		def champion_params
			params.require(:champion)
		end
end
