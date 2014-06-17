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
		@swap = Champion.new
		# Fill @roster array with empty champions
		for x in 0..4
			if current_user.champions.where("position = #{x+1}").exists?
				# So it turns out that .where() returns an array of ActiveRecord::Relation).
				# In order to get the single object, must use .first
				@roster << current_user.champions.where("position = #{x+1}").first
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
		@bench = current_user.champions.where("position = '0'")
		@bench.sort_by! { |champ| champ.level }
		@bench.reverse!
		@roster = current_user.champions.where("position != '0'")
	end
	
	def change_roster
		# Can't swap unless you have 5 champs already...
		new_position = params[:position].to_i
		# Bheck if the new id exists
		if Champion.where(:id =>params[:new_id]).blank?
			flash[:danger] = "Second champion doesn't exist"
			redirect_to roster_path

		# Check if the second champion is yours
		elsif Champion.find(params[:new_id]).user != current_user
			flash[:danger] = "You don't own the second champion"
			redirect_to roster_path

		# Check to see if the first champion is empty
		elsif params[:empty].to_i == 999
			@new_champ = Champion.find(params[:new_id])
			@new_champ.position = params[:position]
			@new_champ.save
			flash[:success] = "Position updated"
			redirect_to roster_path

		# Check that the old id exist
		elsif Champion.where(:id => params[:old_id]).blank?
			flash[:danger] = "First champion doesn't exist"
			redirect_to roster_path

		# Ensure that the first champions is the current user's
		elsif Champion.find(params[:old_id]).user != current_user
			flash[:danger] = "You don't own the first champion"
			redirect_to roster_path
		else
			@old_champ = Champion.find(params[:old_id])
			@new_champ = Champion.find(params[:new_id])
			@old_champ.update(position: 0)
			@new_champ.update(position: params[:position])
			flash[:success] = "#{@old_champ.table_champion.champ_name} was swapped out for #{@new_champ.table_champion.champ_name}"
			redirect_to roster_path
		end

	end

	def spawn_champion
		@champion = current_user.champions.build(spawn_params)
		if @champion.save
			flash[:success] = "Champion id:#{@champion.id} Level:#{@champion.level} Position: #{@champion.position} User id: #{current_user.id}"
			redirect_to current_user
		else
			flash[:danger] = "Messed up. Probably the skin code"
			redirect_to current_user
		end
	end

	def spawn_champion_page
		@champion = current_user.champions.build
	end

	def rankings
		@champions = Champion.reorder("level DESC").page(params[:page]).per_page(30)
		@champions.sort_by! do |champion|
			champion.level
		end
		@champions.reverse!
		# @champions = @champions.paginate(page: params[:page])
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
