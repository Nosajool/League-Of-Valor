class RiftBattle
	attr_reader :log
	attr_reader :battle_id

	def initialize(roster,opp_roster)
		@log = []
		@team = Array.new
		@event_num = 0
		@opp_team = Array.new

		create_battle_record(roster,opp_roster)

		roster.each do |champ|
			@team << BattleChampion.new(champ,@battle_id)
		end
		opp_roster.each do |champ|
			@opp_team << BattleChampion.new(champ,@battle_id)
		end

		@champ_speeds = speed_order
		create_range_record
		@battle_end = false
	end

	# Does not return anyting
	def battle
		cooldown = 0
		turn = 0
		while(!@battle_end) do
			create_turn_update_record(turn)
			@champ_speeds.each do |x|
				create_hp_update_record

				# x is @team's champions
				if(x < 5)
					target = 0
					in_front = team_dead(@team)
					alive_in_front = in_front[0...x].count(false)
					Rails.logger.debug "Alive in front for #{@team[x].name}: #{alive_in_front} Range: #{@team[x].range}"

					while(@opp_team[target].is_dead) do
						Rails.logger.debug "#{target} is already dead. Shifting to #{target + 1}"
						target += 1				
					end

					if @team[x].range < alive_in_front
						create_nothing_in_range_record(x,@team[x].range,alive_in_front)
					else
						create_champion_turn_record(x,target + 5)
						# Ability power attack
						if(cooldown == 0)

							# Handle ability attack
							champ_ap = @team[x].ap
							create_ability_power_record(x,champ_ap)

							champ_mr = @opp_team[target].mr
							create_mr_record(champ_mr,target + 5)

							damage = @opp_team[target].take_magic_damage(champ_ap)
							create_damage_record(x,damage,target + 5)
						else

							# Handle physical attack
							champ_ad = @team[x].ad
							create_attack_damage_record(x,champ_ad)

							champ_ar = @opp_team[target].armor
							create_armor_record(champ_ar, target + 5)

							damage = @opp_team[target].take_physical_damage(champ_ad)
							create_damage_record(x,damage,target + 5)
						end				
					end

					

				else # x > 5
					# x is @opp_team's champions
					
					target = 0
					in_front = team_dead(@opp_team)
					alive_in_front = in_front[0...(x-5)].count(false)
					Rails.logger.debug "Alive in front for #{@opp_team[x-5].name}: #{alive_in_front} Range: #{@opp_team[x-5].range}"

					while(@team[target].is_dead) do
						Rails.logger.debug "#{target} is already dead. Shifting to #{target + 1}"
						target += 1
					end

					if @opp_team[x-5].range < alive_in_front
						create_nothing_in_range_record(x,@opp_team[x-5].range,alive_in_front)
					else

						create_champion_turn_record(x,target)

						if(cooldown == 0)

							champ_ap = @opp_team[x-5].ap
							create_ability_power_record(x,champ_ap)

							champ_mr = @team[target].mr
							create_mr_record(champ_mr,target)

							damage = @team[target].take_magic_damage(champ_ap)
							create_damage_record(x,damage,target)

						else
							champ_ad = @opp_team[x-5].ad
							create_attack_damage_record(x,champ_ad)

							champ_ar = @team[target].armor
							create_armor_record(champ_ar, target)

							damage = @team[target].take_physical_damage(champ_ad)
							create_damage_record(x,damage,target)
						end
					end


				end
				break if create_battle_end_record
			end
			turn = turn + 1
			cooldown = cooldown + 1
			cooldown = 0 if cooldown == 3
			break if create_battle_end_record
		end
	end

	def victory?
		a = team_dead(@team)
		post_battle
		create_hp_update_record
		if(a[5] == 5)
			return false
		else
			return true
		end
	end

	private
		# Logging
		def create_battle_record(roster,opp_roster)
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
			@log[@log.size] = "Battle log id: #{@battle_id}"
			Rails.logger.debug "Battle log id: #{@battle_id}"			
		end

		def create_hp_update_record
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "health update",
				champ1: @team[0].hp,
				champ2: @team[1].hp,
				champ3: @team[2].hp,
				champ4: @team[3].hp,
				champ5: @team[4].hp,
				ochamp1: @opp_team[0].hp,
				ochamp2: @opp_team[1].hp,
				ochamp3: @opp_team[2].hp,
				ochamp4: @opp_team[3].hp,
				ochamp5: @opp_team[4].hp
			})
			@event_num += 1
		end

		def create_champion_turn_record(x,target)
			@log[@log.size] = "#{x}'s turn to attack"
			Rails.logger.debug "#{x}'s turn to attack"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "target selection",
				champion_id: x,
				extra: target
			})
			@event_num += 1
		end

		def create_ability_power_record(x,ap)
			@log[@log.size] = "Your #{x}'s ap is: #{ap}"
			Rails.logger.debug "Your #{x}'s ap is: #{ap}"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "ability power",
				champion_id: x,
				extra: ap
			})
			@event_num += 1
		end

		def create_attack_damage_record(x,ad)
			@log[@log.size] = "Your #{x}'s ad is: #{ad}"
			Rails.logger.debug "Your #{x}'s ad is: #{ad}"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "attack damage",
				champion_id: x,
				extra: ad
			})
			@event_num += 1
		end

		def create_damage_record(x,damage,target)
			@log[@log.size] = "Your #{x} dealt #{damage} to #{target}"
			Rails.logger.debug "Your #{x} dealt #{damage} to #{target}"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "damage",
				champion_id: x,
				other_champion_id: target,
				extra: damage
			})
			@event_num += 1
		end

		def create_mr_record(mr,target)
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "magic resist",
				champion_id: target,
				extra: mr
			})
			@event_num += 1			
		end

		def create_armor_record(armor,target)
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "armor",
				champion_id: target,
				extra: armor
			})
			@event_num += 1				
		end

		def create_turn_update_record(turn)
			@log[@log.size] = "Turn ##{turn}"
			Rails.logger.debug "Turn ##{turn}"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "turn",
				extra: turn
			})	
			@event_num += 1	
		end

		def create_nothing_in_range_record(x,range,num_in_front)
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "out of range",
				champion_id: x,
				extra: range,
				other_champion_id: num_in_front
			})	
			@event_num += 1				
		end

		def create_battle_end_record
			a = team_dead(@team)
			b = team_dead(@opp_team)
			for x in 0..4
				if a[x] == true
					a[x] = 1
				else
					a[x] = 0
				end
				if b[x] == true
					b[x] = 1
				else
					b[x] = 0
				end
			end
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "battle end check",
				champ1: a[0],
				champ2: a[1],
				champ3: a[2],
				champ4: a[3],
				champ5: a[4],
				ochamp1: b[0],
				ochamp2: b[1],
				ochamp3: b[2],
				ochamp4: b[3],
				ochamp5: b[4]				
			})
			@event_num += 1
			@log[@log.size] = "Team death: 0:#{a[0]} 1:#{a[1]} 2: 3:#{a[3]} 4:#{a[4]} 5:#{5}"
			Rails.logger.debug "Team death: 0:#{a[0]} 1:#{a[1]} 2: 3:#{a[3]} 4:#{4} 5:#{5}"

			@log[@log.size] = "Opp Team death: 0:#{b[0]} 1:#{b[1]} 2: 3:#{b[3]} 4:#{b[4]} 5:#{b[5]}"
			Rails.logger.debug "Opp Team death: 0:#{b[0]} 1:#{b[1]} 2: 3:#{b[3]} 4:#{b[4]} 5:#{b[5]}"

			if(a[5] == 5 || b[5] == 5)
				@battle_end = true
			end

			@log[@log.size] = "Checked battle end result: #{@battle_end}"
			Rails.logger.debug "Checked battle end result: #{@battle_end}"

			@battle_end
		end

		def create_speed_record(x,ms)
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "movespeed",
				champion_id: x,
				extra: ms
			})
			@event_num += 1				
		end

		def create_order_record(speed_array)
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "attack order",
				champ1: speed_array[0],
				champ2: speed_array[1],
				champ3: speed_array[2],
				champ4: speed_array[3],
				champ5: speed_array[4],
				ochamp1: speed_array[5],
				ochamp2: speed_array[6],
				ochamp3: speed_array[7],
				ochamp4: speed_array[8],
				ochamp5: speed_array[9]
			})
			@event_num += 1			
		end

		def create_range_record
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "range",
				champ1: @team[0].range,
				champ2: @team[1].range,
				champ3: @team[2].range,
				champ4: @team[3].range,
				champ5: @team[4].range,
				ochamp1: @opp_team[0].range,
				ochamp2: @opp_team[1].range,
				ochamp3: @opp_team[2].range,
				ochamp4: @opp_team[3].range,
				ochamp5: @opp_team[4].range
			})
			@event_num += 1				
		end
		# Returns an array of size 10 with values ranging from 0-9
		def speed_order
			all_champions = @team.concat(@opp_team)
			speed_hash = Hash.new
			for x in 0..9
				speed_hash[x]  = all_champions[x].ms
				create_speed_record(x,all_champions[x].ms)
			end
			sorted_speed_hash = speed_hash.sort_by{|num,speed| speed}.reverse
			new_speed_array = Array.new
			sorted_speed_hash.each do |num, speed|
				new_speed_array << num
			end
			create_order_record(new_speed_array)
			new_speed_array
		end

		# Returns a bool

		def team_dead(team)
			dead_array = Array.new
			count = 0
			team.each do |champ|
				dead_array << champ.is_dead
				if champ.is_dead
					count += 1
				end
			end
			dead_array << count
			dead_array
		end

		def convert_x_to_id(x)
			id = 0
			if(x < 5)
				id = @team[x].id
			else
				id = @opp_team[x-5].id
			end
			return id
		end




		def post_battle
			b = team_dead(@opp_team)
			for i in 0..4
				if(b[i])
					exp = @opp_team[i].exp_reward(@event_num, i + 5)
					@event_num += 1
					for x in 0..4 do
						@team[x].gain_exp(exp,@event_num,x)
						@event_num += 3
					end
				end
			end
			for x in 0..4 do
				@team[x].update_champion_stats(@event_num,x)
				@event_num += 2
			end
		end
end