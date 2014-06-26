class Battle

	def initialize(roster,opp_roster)
		@team = BattleTeam.new(roster)
		@opp_team = BattleTeam.new(opp_roster)
	end



end