class Battle

	def initialize(roster,opp_roster)
		@team = BattleTeam.new(roster)
		@opp_team = BattleTeam.new(opp_roster)
		@champ_speeds = speed_order
		@battle_end = false
	end

	def battle
		while(!@battle_end)

			break if check_battle_end
		end
	end




	private
		def speed_order
			speed_array = @team.team_speed.concat(@opp_team.team_speed)
			speed_hash = Hash.new
			x = 1
			speed_array.each do |speed|
				@speed_hash[x] = speed
				x = x + 1
			end
			speed_hash
		end

		def check_battle_end
			unless(@team.check_defeat && @opp_team.check_defeat)
				@battle_end = true
			end
			@battle_end
		end
end