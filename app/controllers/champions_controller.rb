class ChampionsController < ApplicationController
	# Under Construction
	# Will handle catching champions
	before_action :signed_in_user

	def create
		# @champion = current_user.champions.build(champion_params)
		# if @champion.save
		# 	# Change this to the champion name
		# 	flash[:success] = "You caught a #{@champion.table_champion_id}!"
		# 	# Change this to the map that you came from
		# 	redirect_to root_url
		# else
		# 	# Redirect somewhere else
		# 	render root_url
		# end
	end

	def edit
		# Can't switch ppl that are in your roster...(Like can't switch from position 1 to 5)
		@champion_count = current_user.champions.count
		@roster = []
		# Fill @roster array with empty champions
		for x in 0..4
			if current_user.champions.where("position == #{x+1}").exists?
				# So it turns out that .where() returns an array of ActiveRecord::Relation).
				# In order to get the single object, must use .first
				@roster << current_user.champions.where("position == #{x+1}").first
			else
				@roster << Champion.new(:table_champion_id=>999,
											 :experience=>0, 
											 :position=>x+1, 
											 :skin=>1111111111,
											 :active_skin=>0,
											 :level=>1)
			end
		end
		@non_roster = current_user.champions.where("position = '0'")
		@non_roster.sort_by! { |champ| champ.table_champion.champ_name }
	end

	def bench
		@bench = current_user.champions.where("position == '0'")
		@bench.sort_by! { |champ| champ.level }
		@bench.reverse!
		@roster = current_user.champions.where("position != '0'")
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

	def spawn_champion
		@champion = current_user.champions.build(spawn_params)
		if @champion.save
			flash[:success] = "Champion created!"
			redirect_to current_user
		else
			flash[:danger] = "Messed up. Probably the skin code"
			redirect_to current_user
		end
	end

	def spawn_champion_page
		@champion = current_user.champions.build
	end

	private
	# Incorporate champion_params to make more secure
		def champion_params
			params.require(:champion)
		end

		def spawn_params
			params.require(:champion).permit(:table_champion_id, :experience, :position, :skin, :active_skin, :level)
		end
end
