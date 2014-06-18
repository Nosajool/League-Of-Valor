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
  		@map_champions.each do |champ|
  			if rand_num < champ.probability
  				@random_champ = TableChampion.find(champ.champ_id)
  				break
  			end
  		end

  	end

  	private
  		def rand_num
  			1 + rand(100)
  		end
end
