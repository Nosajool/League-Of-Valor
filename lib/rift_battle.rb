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
				create_champion_turn_record(x)

				# x is @team's champions
				if(x < 5)

					target = 0
					while(@opp_team[target].is_dead) do
						@log[@log.size] = "#{target} is already dead. Shifting to #{target + 1}"
						Rails.logger.debug "#{target} is already dead. Shifting to #{target + 1}"
						target += 1				
					end

					# Ability power attack
					if(cooldown == 0)

						# Handle ability attack
						champ_ap = @team[x].ap

						create_ability_power_record(x,champ_ap)

						damage = @opp_team[target].take_magic_damage(champ_ap)

						create_damage_record(x,damage,target)
					else

						# Handle physical attack
						champ_ad = @team[x].ad

						create_attack_damage_record(x,champ_ad)

						damage = @opp_team[target].take_physical_damage(champ_ad)

						create_damage_record(x,damage,target)
					end

				else # x > 5
					# x is @opp_team's champions
					
					target = 0

					while(@team[target].is_dead) do
						@log[@log.size] = "#{target} is already dead. Shifting to #{target + 1}"
						Rails.logger.debug "#{target} is already dead. Shifting to #{target + 1}"
						target += 1
					end


					if(cooldown == 0)

						champ_ap = @opp_team[x-5].ap

						@log[@log.size] = "Opponent's #{x}'s ability power: #{champ_ap}"
						Rails.logger.debug "Opponent's #{x}'s ability power: #{champ_ap}"

						damage = @team[target].take_magic_damage(champ_ap)

						create_damage_record(x,damage,target)
					else
						champ_ad = @opp_team[x-5].ad

						@log[@log.size] = "Opponent's #{x} attack damage is: #{champ_ad}"
						Rails.logger.debug "Opponent's #{x} attack damage is: #{champ_ad}"

						damage = @team[target].take_physical_damage(champ_ad)

						create_damage_record(x,damage,target)
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

		def create_champion_turn_record(x)
			id = convert_x_to_id(x)
			@log[@log.size] = "#{x}'s turn to attack"
			Rails.logger.debug "#{x}'s turn to attack"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "target selection",
				champion_id: id,
				extra: x
			})
			@event_num += 1
		end

		def create_ability_power_record(x,ap)
			id = convert_x_to_id(x)
			@log[@log.size] = "Your #{x}'s ap is: #{ap}"
			Rails.logger.debug "Your #{x}'s ap is: #{ap}"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "ability power",
				champion_id: id,
				extra: ap
			})
			@event_num += 1
		end

		def create_attack_damage_record(x,ad)
			id = convert_x_to_id(x)
			@log[@log.size] = "Your #{x}'s ad is: #{ad}"
			Rails.logger.debug "Your #{x}'s ad is: #{ad}"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "attack damage",
				champion_id: id,
				extra: ad
			})
			@event_num += 1
		end

		def create_damage_record(x,damage,target)
			id = convert_x_to_id(x)
			target_id = convert_x_to_id(target)
			@log[@log.size] = "Your #{x} dealt #{damage} to #{target}"
			Rails.logger.debug "Your #{x} dealt #{damage} to #{target}"
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: @event_num,
				event: "damage",
				champion_id: id,
				other_champion_id: target_id,
				extra: damage
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
		# Returns an array of size 10 with values ranging from 0-9
		def speed_order
			# all_champions = @team.concat(@opp_team)
			# speed_hash = Hash.new
			# for x in 0..9
			# 	speed_hash[x]  = all_champions[x].ms
			# end
			# sorted_speed_hash = speed_hash.sort_by{|num,speed| speed}.reverse
			# new_speed_array = Array.new
			# sorted_speed_hash.each do |num, speed|
			# 	new_speed_array << num
			# end
			# @log[@log.size] = "Speed Order:"
			# new_speed_array.each do |speed|
			# 	@log[@log.size] = speed
			# end
			new_speed_array = Array.new
			(0..9).each do |x|
				new_speed_array << x
			end
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
					exp = @opp_team[i].exp_reward(@event_num)
					@event_num += 1
					@team.each do |champ|
						champ.gain_exp(exp,@event_num)
						@event_num += 3
					end
				end
			end
			@team.each do |champ|
				champ.update_champion_stats(@event_num)
				@event_num += 2
			end
		end
end