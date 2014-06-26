class Battle

	def initialize(roster,opp_roster)
		@team = BattleTeam.new(roster)
		@opp_team = BattleTeam.new(opp_roster)
		@champ_speeds = speed_order
		@battle_end = false
	end

	# Does not return anyting
	def battle
		while(!@battle_end)
			@champ_speeds.each do |x|
				if(x < 5)
					# x is @team's champions
					target = @team.champions[x].attack(@opp_team.targets,x)
					unless(target == 10)
						# attack was successful
					end
				else
					# x is @opp_team's champions
					target = @opp_team.champions[x-5].attack(@team.targets,x-5)
					unless(target == 10)
						# attack was successful
					end
				end

				break if check_battle_end
			end
			break if check_battle_end
		end
	end




	private
		# Returns an array of size 10 with values ranging from 0-9
		def speed_order
			speed_array = @team.team_speed.concat(@opp_team.team_speed)
			speed_hash = Hash.new
			x = 0
			speed_array.each do |speed|
				@speed_hash[x] = speed
				x = x + 1
			end
			sorted_speed_hash = speed_hash.sort_by{|num,speed| speed}.reverse
			new_speed_array = Array.new
			sorted_speed_hash.each do |num, speed|
				new_speed_array << num
			end
			new_speed_array
		end

		# Returns a bool
		def check_battle_end
			unless(@team.check_defeat && @opp_team.check_defeat)
				@battle_end = true
			end
			@battle_end
		end
end