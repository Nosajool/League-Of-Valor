class MapsController < ApplicationController
	before_action :signed_in_user
  	def index
  		@maps = Map.all
  	end

  	def show
  		@map = Map.find(params[:id])
  		# Should get array of champions available on this map
  		@map_champions = @map.map_champions
  		num = rand_num
  		@map_champions.each do |map_champ|
  			if num <= map_champ.probability
          # Change this to find by the Key
  				@random_champ = TableChampion.where(key: map_champ.key).first
  				break
  			end
  		end
  	end

	def catch
		@champion = current_user.champions.build(champion_hash(params[:champ_id]))
		name = TableChampion.find(params[:champ_id]).name
		if @champion.save
			flash[:success] = "Congratulations, the level 1 #{name} has been added to your bench!"
			redirect_to current_user
		else
			flash[:danger] = "Did not catch"
			redirect_to current_user
		end
  	end

  	private
  		def rand_num
  			1 + rand(100)
  		end

  		def champion_hash(id)
  			champ = Hash.new
  			champ[:level] = 1
  			champ[:position] = 0
  			champ[:experience] = 1
  			champ[:skin] = 1000000000
  			champ[:active_skin] = 0
  			champ[:table_champion_id] = id
  			champ
  		end
end
