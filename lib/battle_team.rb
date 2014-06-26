class BattleTeam

	def initialize(roster)
		@champ1 = BattleChampion.new(roster[0])	
		@champ2 = BattleChampion.new(roster[1])
		@champ3 = BattleChampion.new(roster[2])
		@champ4 = BattleChampion.new(roster[3])
		@champ5 = BattleChampion.new(roster[4])
		@standing = true
	end

	def check_defeat
		@standing = false if(@champ1.check_dead && @champ2.check_dead && @champ3.check_dead && @champ4.check_dead && @champ4.check_dead)
		@standing
	end

	def team_speed
		speed_arr = Array.new
		speed_arr << @champ1.ms << @champ2.ms << @champ3.ms << @champ4.ms << @champ5.ms
	end
	private
	
end