class RiftBattle
	attr_reader :log
	attr_reader :battle_id

	def initialize(roster,opp_roster)
		@team = Array.new
		@event_num = 0
		@opp_team = Array.new
		@turn = 0
		@attacker = roster[0].user
		@defender = opp_roster[0].user

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
		while(!@battle_end) do
			create_turn_update_record(@turn)
			@champ_speeds.each do |x|
				create_hp_update_record

				# x is @team's champions
				if(x < 5)
					in_front = team_dead(@team)
					num_alive_in_front = in_front[0...x].count(false)
					range = @team[x].range
					name = @team[x].name
					Rails.logger.debug "Alive in front on team for #{name}: #{num_alive_in_front} Range: #{range}}"

					if range <= num_alive_in_front
						Rails.logger.debug "Nothing in range for #{name}"
						create_nothing_in_range_record(x,range,num_alive_in_front)
					else
						opp_in_front = team_dead(@opp_team)
						range_left = range - num_alive_in_front
						Rails.logger.debug "Range: #{range} Range Left: #{range_left}"
						num_opp_alive = opp_in_front.count(false)
						Rails.logger.debug "Number of opponents alive: #{num_opp_alive}"
						if range_left <= num_opp_alive
							num_opp_alive = range_left
							Rails.logger.debug "Targets for randomming decreased from #{num_opp_alive} to the range: #{range_left}"
						end

						random_target = randomized_target(num_opp_alive)
						Rails.logger.debug "Random Target: #{random_target}"

						target = -1
						temp = -1
						for y in 0..4
							if (!opp_in_front[y])
								temp += 1
								Rails.logger.debug "#{@opp_team[y].name} is alive in front of #{name}"
							end
							if(temp == random_target)
								target = y
								Rails.logger.debug "temp: #{temp} y: #{y} random_target: #{random_target}"
								break
							end
						end
						Rails.logger.debug "Thus the target is: #{@opp_team[target].name} at position: #{target}"

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
							create_just_dead_record(x,target + 5) if @opp_team[target].just_died?
						else

							# Handle physical attack
							champ_ad = @team[x].ad
							create_attack_damage_record(x,champ_ad)

							champ_ar = @opp_team[target].armor
							create_armor_record(champ_ar, target + 5)

							damage = @opp_team[target].take_physical_damage(champ_ad)
							create_damage_record(x,damage,target + 5)
							create_just_dead_record(x,target + 5) if @opp_team[target].just_died?
						end				
					end

					

				else # x > 5
					# x is @opp_team's champions
					
					in_front = team_dead(@opp_team)
					num_alive_in_front = in_front[0...(x-5)].count(false)
					range = @opp_team[x-5].range
					name = @opp_team[x-5].name
					Rails.logger.debug "Alive in front for #{name}: #{num_alive_in_front} Range: #{range}"

					if range <= num_alive_in_front
						Rails.logger.debug "Nothing in range for #{name}"
						create_nothing_in_range_record(x,range,num_alive_in_front)
					else
						opp_in_front = team_dead(@team)
						range_left = @opp_team[x-5].range - num_alive_in_front
						Rails.logger.debug "Range: #{range} Range Left: #{range_left}"
						num_opp_alive = opp_in_front.count(false)
						Rails.logger.debug "Number team alive: #{num_opp_alive}"
						if range_left <= num_opp_alive
							num_opp_alive = range_left
							Rails.logger.debug "Targets for randomming decreased from #{num_opp_alive} to #{range_left}"
						end

						random_target = randomized_target(num_opp_alive)
						Rails.logger.debug "Random Target: #{random_target}"

						target = -1
						temp = -1
						for y in 0..4
							if (!opp_in_front[y])
								temp += 1
								Rails.logger.debug "#{@team[y].name} is alive in front of #{name}"
							end
							if(temp == random_target)
								target = y
								Rails.logger.debug "temp: #{temp} y: #{y} random_target: #{random_target}"
								break
							end
						end
						Rails.logger.debug "Thus the target is: #{@team[target].name} at position: #{target}"


						create_champion_turn_record(x,target)

						if(cooldown == 0)

							champ_ap = @opp_team[x-5].ap
							create_ability_power_record(x,champ_ap)

							champ_mr = @team[target].mr
							create_mr_record(champ_mr,target)

							damage = @team[target].take_magic_damage(champ_ap)
							create_damage_record(x,damage,target)
							create_just_dead_record(x,target) if @team[target].just_died?

						else
							champ_ad = @opp_team[x-5].ad
							create_attack_damage_record(x,champ_ad)

							champ_ar = @team[target].armor
							create_armor_record(champ_ar, target)

							damage = @team[target].take_physical_damage(champ_ad)
							create_damage_record(x,damage,target)
							create_just_dead_record(x,target) if @team[target].just_died?
						end
					end


				end
				break if create_battle_end_record
			end
			@turn = @turn + 1
			cooldown = cooldown + 1
			cooldown = 0 if cooldown == 3
			break if create_battle_end_record
		end
	end

	def victory?
		a = team_dead(@team)
		post_battle
		@turn = @turn + 1
		create_end_turn_update_record(@turn,a[5])
		if(a[5] == 5)
			return false
		else
			check_buff_transfer
			return true
		end
	end

	private
		# Logging
		def create_battle_record(roster,opp_roster)
			@battle_record = Battle.create!({
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
			@battle_id = @battle_record.id
			Rails.logger.debug "Battle log id: #{@battle_id}"			
		end

		def create_hp_update_record
			@battle_record.battle_logs.create!({
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
			Rails.logger.debug "#{x}'s turn to attack"
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "target selection",
				champion_id: x,
				extra: target
			})
			@event_num += 1
		end

		def create_ability_power_record(x,ap)
			Rails.logger.debug "Your #{x}'s ap is: #{ap}"
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "ability power",
				champion_id: x,
				extra: ap
			})
			@event_num += 1
		end

		def create_attack_damage_record(x,ad)
			Rails.logger.debug "Your #{x}'s ad is: #{ad}"
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "attack damage",
				champion_id: x,
				extra: ad
			})
			@event_num += 1
		end

		def create_damage_record(x,damage,target)
			Rails.logger.debug "Your #{x} dealt #{damage} to #{target}"
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "damage",
				champion_id: x,
				other_champion_id: target,
				extra: damage
			})
			@event_num += 1
		end

		def create_mr_record(mr,target)
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "magic resist",
				champion_id: target,
				extra: mr
			})
			@event_num += 1			
		end

		def create_armor_record(armor,target)
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "armor",
				champion_id: target,
				extra: armor
			})
			@event_num += 1				
		end

		def create_turn_update_record(turn)
			Rails.logger.debug "Turn ##{turn}"
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "turn",
				champ1: @team[0].hp,
				champ2: @team[1].hp,
				champ3: @team[2].hp,
				champ4: @team[3].hp,
				champ5: @team[4].hp,
				ochamp1: @opp_team[0].hp,
				ochamp2: @opp_team[1].hp,
				ochamp3: @opp_team[2].hp,
				ochamp4: @opp_team[3].hp,
				ochamp5: @opp_team[4].hp,
				extra: @turn
			})	
			@event_num += 1	
		end
		def create_end_turn_update_record(turn,numdead)
			Rails.logger.debug "End Turn ##{turn}"
			a = 0
			b = 0
			if(numdead == 5)
				b = 1
			else
				a = 1
			end
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "end turn",
				champ1: @team[0].hp,
				champ2: @team[1].hp,
				champ3: @team[2].hp,
				champ4: @team[3].hp,
				champ5: @team[4].hp,
				ochamp1: @opp_team[0].hp,
				ochamp2: @opp_team[1].hp,
				ochamp3: @opp_team[2].hp,
				ochamp4: @opp_team[3].hp,
				ochamp5: @opp_team[4].hp,
				extra: @turn,
				champion_id: a,
				other_champion_id: b
			})	
			@event_num += 1	
		end

		def create_nothing_in_range_record(x,range,num_in_front)
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "out of range",
				champion_id: x,
				extra: range,
				other_champion_id: num_in_front
			})	
			@event_num += 1				
		end

		def create_just_dead_record(x,target)
			@battle_record.battle_logs.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "just died",
				champion_id: x,
				other_champion_id: target
			})
			@event_num += 1
		end

		def create_battle_end_record
			a = team_dead(@team)
			b = team_dead(@opp_team)
			a_count = 0
			b_count = 0
			for x in 0..4
				if a[x] == true
					a[x] = 1
					a_count += 1
				else
					a[x] = 0
				end
				if b[x] == true
					b[x] = 1
					b_count += 1
				else
					b[x] = 0
				end
			end
			a[5] = a_count
			b[5] = b_count
			@battle_record.battle_logs.create!({
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
			Rails.logger.debug "Team death: #{@team[0].name}:#{a[0]} #{@team[1].name}:#{a[1]} #{@team[2].name}:#{a[2]} #{@team[3].name}:#{a[3]} #{@team[4].name}:#{a[4]} Dead Count:#{a[5]}"

			Rails.logger.debug "Opp Team death: #{@opp_team[0].name}:#{b[0]} #{@opp_team[1].name}:#{b[1]} #{@opp_team[2].name}:#{b[2]} #{@opp_team[3].name}:#{b[3]} #{@opp_team[4].name}:#{b[4]} Dead Count:#{b[5]}"

			if(a[5] == 5 || b[5] == 5)
				@battle_end = true
			end

			Rails.logger.debug "Checked battle end result: #{@battle_end}"

			@battle_end
		end

		def create_speed_record(x,ms)
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "movespeed",
				champion_id: x,
				extra: ms
			})
			@event_num += 1				
		end

		def create_order_record(speed_array)
			@battle_record.battle_logs.create!({
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
			@battle_record.battle_logs.create!({
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

		def create_buff_acquire_record(attacker_id,defender_id,buff_id)
			@battle_record.battle_logs.create!({
				event_num: @event_num,
				event: "buff acquire",
				extra: buff_id,
				champion_id: attacker_id,
				other_champion_id: defender_id
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

		def randomized_target(target_size)
			x = 1 + rand(100)
			case target_size
			when 1
				return 0
			when 2
				if (x <= 70)
					return 0
				else
					return 1
				end
			when 3
				if(x <= 55)
					return 0
				elsif(x <= 85)
					return 1
				else
					return 2
				end
			when 4
				if(x <= 50)
					return 0
				elsif(x <= 70)
					return 1
				elsif(x <= 80)
					return 2
				else
					return 3
				end
			when 5
				if(x <= 50)
					return 0
				elsif(x <= 75)
					return 1
				elsif(x <= 90)
					return 2
				elsif(x <= 98)
					return 3
				else
					return 4
				end					
			end
		end

		def check_buff_transfer
			if @attacker.buff.nil?
				if @defender.buff.nil?
					Rails.logger.debug "Neither player had a buff"
				else
					new_buff = @defender.buff
					new_buff.user_id = @attacker.id
					new_buff.save
					create_buff_acquire_record(@attacker.id,@defender.id,new_buff.id)
					Rails.logger.debug "#{new_buff.title} transfered from #{@defender.username} to #{@attacker.username}"
				end
			else
				if @defender.buff.nil?
					Rails.logger.debug "Attacker has the #{@attacker.buff.title} but the defender has no buff"
				else
					Rails.logger.debug "Both players had buffs. Handle this case"
				end
			end
		end
end