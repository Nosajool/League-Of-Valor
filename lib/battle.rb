class Battle
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
		create_battle_record(roster,opp_roster)
	end

	# Does not return anyting
	def battle
		cooldown = 0
		turn = 0
		while(!@battle_end)
			log_hp_update
			log_turn_update(turn)
			@champ_speeds.each do |x|
				@log[@log.size] = "#{x}'s turn to attack"
				# x is @team's champions
				if(x < 5)
					target = @team.champions[x].attack(@opp_team.targets,x)
					@log[@log.size] = "Your #{x}'s target"
					# Ability power attack
					if(cooldown == 0)
						@log[@log.size] = "Your #{x}'s ability power attack"
						unless(target == 10)
							@log[@log.size] = "Your #{x}'s Ability power hit"
							# Handle ability attack
							champ_ap = @team.get_ap(x)
							@log[@log.size] = "Your #{x}'s ap is: #{champ_ap}"
							damage = @opp_team.magic_attack(champ_ap,target)
							@log[@log.size] = "Your #{x} dealt #{damage} to #{target}"
						end
						break if check_battle_end
					else
						@log[@log.size] = "Your #{x}'s Attack Damage attack"
						unless(target == 10)
							@log[@log.size] = "Your #{x}'s Attack damage hit"
							# Handle physical attack
							champ_ad = @team.get_ad(x)
							@log[@log.size] = "Your #{x}'s ad is: #{champ_ad}"
							damage = @opp_team.physical_attack(champ_ad,target)
							@log[@log.size] = "Your #{x} dealt #{damage} to #{target}"
						end
						break if check_battle_end
					end

				else
					target = @opp_team.champions[x-5].attack(@team.targets,x-5)
					@log[@log.size] = "Opponent's #{x}'s target"
					if(cooldown == 0)
						@log[@log.size] = "opponent's #{x}'s Ability Power attack"
						unless(target == 10)
							@log[@log.size] = "Opponent's #{x}'s' ability power hit"
							# Handle ability attack
							champ_ap = @opp_team.get_ap(x-5)
							@log[@log.size] = "Opponent's #{x}'s ability power: #{champ_ap}"
							damage = @team.magic_attack(champ_ap,target)
							@log[@log.size] = "Opponent's #{x} dealt #{damage} to #{target}"
						end
						break if check_battle_end
					else
						@log[@log.size] = "Opponent's #{x}'s Attack damage atttack"
						# x is @opp_team's champions
						unless(target == 10)
							@log[@log.size] = "Opponent #{x}'s attack damage hit"
							# Handle auto attack
							champ_ad = @opp_team.get_ad(x-5)
							@log[@log.size] = "Opponent's #{x} attack damage is: #{champ_ad}"
							damage = @team.physical_attack(champ_ad,target)
							@log[@log.size] = "Opponent #{x} dealt #{damage} to #{target}"
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
			all_champions = @team.concat(@opp_team)
			speed_hash = Hash.new
			for x in 0..9
				speed_hash[x]  = all_champions[x].ms
			end
			sorted_speed_hash = speed_hash.sort_by{|num,speed| speed}.reverse
			new_speed_array = Array.new
			sorted_speed_hash.each do |num, speed|
				new_speed_array << num
			end
			@log[@log.size] = "Speed Order:"
			new_speed_array.each do |speed|
				@log[@log.size] = speed
			end
			new_speed_array
		end

		# Returns a bool
		def check_battle_end
			unless(@team.check_defeat && @opp_team.check_defeat)
				@battle_end = true
			end
			@log[@log.size] = "Checked battle end result: #{@battle_end}"
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

		def log_hp_update
			@log[@log.size] = "Your Team's information:"
			@team.each do |champ|
				@log[@log.size] = "#{champ.name} Level: #{champ.level} hp:#{champ.hp} ad:#{champ.ad} dead: #{champ.is_dead}"
			end
			@log[@log.size] = "Your Opponent's Team's information:"
			@opp_team.each do |champ|
				@log[@log.size] = "#{champ.name} Level: #{champ.level} hp:#{champ.hp} ad:#{champ.ad} dead: #{champ.is_dead}"
			end
		end

		def log_turn_update(turn)
			@log[@log.size] = "Turn ##{turn}"
		end
end