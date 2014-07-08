class RiftBattle
	attr_reader :log

	def initialize(roster,opp_roster)
		@log = []
		@team = Array.new
		@opp_team = Array.new

		roster.each do |champ|
			@team << BattleChampion.new(champ)
		end
		opp_roster.each do |champ|
			@opp_team << BattleChampion.new(champ)
		end

		@champ_speeds = speed_order
		@battle_end = false
		# create_battle_record(roster,opp_roster)
	end

	# Does not return anyting
	def battle
		cooldown = 0
		turn = 0
		while(!@battle_end) do
			log_turn_update(turn)
			@champ_speeds.each do |x|
				log_hp_update

				@log[@log.size] = "#{x}'s turn to attack"
				Rails.logger.debug "#{x}'s turn to attack"

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

						@log[@log.size] = "Your #{x}'s ability power attack"
						Rails.logger.debug"Your #{x}'s ability power attack"

						# Handle ability attack
						champ_ap = @team[x].ap

						@log[@log.size] = "Your #{x}'s ap is: #{champ_ap}"
						Rails.logger.debug "Your #{x}'s ap is: #{champ_ap}"

						damage = @opp_team[target].take_magic_damage(champ_ap)

						@log[@log.size] = "Your #{x} dealt #{damage} to #{target}"
						Rails.logger.debug "Your #{x} dealt #{damage} to #{target}"
					else
						@log[@log.size] = "Your #{x}'s Attack Damage attack"
						Rails.logger.debug "Your #{x}'s Attack Damage attack"

						# Handle physical attack
						champ_ad = @team[x].ad

						@log[@log.size] = "Your #{x}'s ad is: #{champ_ad}"
						Rails.logger.debug "Your #{x}'s ad is: #{champ_ad}"

						damage = @opp_team[target].take_physical_damage(champ_ad)

						@log[@log.size] = "Your #{x} dealt #{damage} to #{target}"
						Rails.logger.debug "Your #{x} dealt #{damage} to #{target}"
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
						@log[@log.size] = "opponent's #{x}'s Ability Power attack"
						Rails.logger.debug "opponent's #{x}'s Ability Power attack"

						champ_ap = @opp_team[x-5].ap

						@log[@log.size] = "Opponent's #{x}'s ability power: #{champ_ap}"
						Rails.logger.debug "Opponent's #{x}'s ability power: #{champ_ap}"

						damage = @team[target].take_magic_damage(champ_ap)

						@log[@log.size] = "Opponent's #{x} dealt #{damage} to #{target}"
						Rails.logger.debug "Opponent's #{x} dealt #{damage} to #{target}"
					else
						@log[@log.size] = "Opponent's #{x}'s Attack damage atttack"
						Rails.logger.debug "Opponent's #{x}'s Attack damage atttack"

						champ_ad = @opp_team[x-5].ad

						@log[@log.size] = "Opponent's #{x} attack damage is: #{champ_ad}"
						Rails.logger.debug "Opponent's #{x} attack damage is: #{champ_ad}"

						damage = @team[target].take_physical_damage(champ_ad)

						@log[@log.size] = "Opponent #{x} dealt #{damage} to #{target}"
						Rails.logger.debug "Opponent #{x} dealt #{damage} to #{target}"
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
		def check_battle_end
			a = team_dead(@team)
			b = team_dead(@opp_team)
			@log[@log.size] = "Team death: 0:#{a[0]} 1:#{a[1]} 2: 3:#{a[3]} 4:#{4} 5:#{5}"
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

		# def create_battle_record
		# 	x = Battle.create!({
		# 	    user_id: roster[0].user.id,
		# 	    opp_id: opp_roster[0].user.id,
		# 	    champ1: roster[0].id,
		# 	    champ2: roster[1].id,
		# 	    champ3: roster[2].id,
		# 	    champ4: roster[3].id,
		# 	    champ5: roster[4].id,
		# 	    champ6: opp_roster[0].id,
		# 	    champ7: opp_roster[1].id,
		# 	    champ8: opp_roster[2].id,
		# 	    champ9: opp_roster[3].id,
		# 	    champ10: opp_roster[4].id
		# 	})
		# 	@battle_id = x.id		
		# end

		def log_hp_update
			@log[@log.size] = "Your Team's information:"
			@team.each do |champ|
				@log[@log.size] = "#{champ.name} Level: #{champ.level} hp:#{champ.hp} ad:#{champ.ad} dead: #{champ.is_dead}"
				Rails.logger.debug "#{champ.name} Level: #{champ.level} hp:#{champ.hp} ad:#{champ.ad} dead: #{champ.is_dead}"
			end
			@log[@log.size] = "Your Opponent's Team's information:"
			@opp_team.each do |champ|
				@log[@log.size] = "#{champ.name} Level: #{champ.level} hp:#{champ.hp} ad:#{champ.ad} dead: #{champ.is_dead}"
				Rails.logger.debug "#{champ.name} Level: #{champ.level} hp:#{champ.hp} ad:#{champ.ad} dead: #{champ.is_dead}"
			end
		end

		def log_turn_update(turn)
			@log[@log.size] = "Turn ##{turn}"
			Rails.logger.debug "Turn ##{turn}"
		end
end