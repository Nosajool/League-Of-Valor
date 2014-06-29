class Battle

	def initialize(roster,opp_roster)
		@team = BattleTeam.new(roster)
		@opp_team = BattleTeam.new(opp_roster)
		@champ_speeds = speed_order
		@battle_end = false
		create_battle_record(roster,opp_roster)
	end

	# Does not return anyting
	def battle
		cooldown = 0
		turn = 0
		while(!@battle_end)
			@champ_speeds.each do |x|
				# x is @team's champions
				if(x < 5)
					target = @team.champions[x].attack(@opp_team.targets,x)
					# Ability power attack
					if(cooldown == 0)
						unless(target == 10)
							# Handle ability attack
							champ_ap = @team.get_ap(x)
							@opp_team.magic_attack(champ_ap,target)
						end
						break if check_battle_end
					else
						unless(target == 10)
							# Handle physical attack
							champ_ad = @team.get_ad(x)
							@opp_team.physical_attack(champ_ad,target)
						end
						break if check_battle_end
					end

				else
					target = @opp_team.champions[x-5].attack(@team.targets,x-5)
					if(cooldown == 0)
						unless(target == 10)
							# Handle ability attack
							champ_ap = @opp_team.get_ap(x-5)
							@team.magic_attack(champ_ap,target)
						end
						break if check_battle_end
					else
						# x is @opp_team's champions
						unless(target == 10)
							# Handle auto attack
							champ_ad = @opp_team.get_ad(x-5)
							@team.physical_attack(champ_ad,target)
						end
						break if check_battle_end
					end
				end

				break if check_battle_end
			end
			turn = turn + 1
			cooldown = cooldown + 1
			cooldown = 0 if cooldown == 3
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

		def create_battle_record
			x = Battle.create!({
			    user_id: roster[0].user.id,
			    opp_id: opp_roster[0].user.id,
			    champ1: roster[0].id,
			    champ2: roster[1].id,
			    champ3: roster[2].id,
			    champ4: roster[3].id,
			    champ5: roster[4].id,
			    champ6: opp_roster[0].id,
			    champ7: opp_roster[1].id,
			    champ8: opp_roster[2].id,
			    champ9: opp_roster[3].id,
			    champ10: opp_roster[4].id
			})
			@battle_id = x.id		
		end
end