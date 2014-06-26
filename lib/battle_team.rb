class BattleTeam
	attr_reader :champions
	attr_reader :standing

	def initialize(roster)
		@champions = Array.new
		roster.each do |champ|
			@champions << BattleChampion.new(champ)
		end
		@standing = true
	end

	# Does not return anything
	def attack(opp_targets)
		# TODO
		alive_team = targets
		
	end

	# Returns an array of size 5 of bool
	def targets
		targets = Array.new
		@champions.each do |champ|
			targets << champ.is_dead
		end
		targets
	end

	# Returns a bool
	def check_defeat
		@champions.each do |champ|
			if champ.is_dead
				@standing = false
			end
		end
		@standing
	end

	# Returns an array of size 5 of integers
	def team_speed
		speed_arr = Array.new
		@champions.each do |champ|
			speed_arr << champ.ms
		end
		speed_arr
	end
	private
	
end