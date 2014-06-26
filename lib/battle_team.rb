class BattleTeam

	def initialize(roster)
		@champ1 = BattleChampion.new(roster[0])	
		@champ2 = BattleChampion.new(roster[1])
		@champ3 = BattleChampion.new(roster[2])
		@champ4 = BattleChampion.new(roster[3])
		@champ5 = BattleChampion.new(roster[4])
		@defeated = false
	end

	def check_defeat
		@defeated = true if(@champ1.check_dead && @champ2.check_dead && @champ3.check_dead && @champ4.check_dead && @champ4.check_dead)
		@defeated
	end
	private
	
end