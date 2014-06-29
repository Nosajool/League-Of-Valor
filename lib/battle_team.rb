class BattleTeam
	attr_reader :champions
	attr_reader :standing

	def initialize(roster)
		@champions = Array.new
		roster.each do |champ|
			@champions << BattleChampion.new(champ)
		end
		@standing = true
	end

	# Returns an integer between 0-4 of who they attack or 10 if can't hit anything
	def attack(opp_targets,position)

		# First check if your range can go past your champion front line
		in_front = targets[0...position].count(true)
		if (@champions[position].range < in_front)
			# There are no champions in range for you to hit
			return 10
		end

		opp_in_front = opp_targets.count(true)
		num_enemies_can_hit = @champions[position].range - in_front

		if num_enemies_can_hit >= opp_in_front
			num_enemies_can_hit = opp_in_front
		end

		target_num = randomized_target(num_enemies_can_hit)
		b = 0
		c = 0
		opp_targets.each do |a|
			if a
				b = b + 1;
			end
			if b == target_num
				return c
			end
			c = c + 1
		end
		
	end

	def get_ad(array_position)
		return @champions[array_position].ad
	end

	def get_ap(array_position)
		return @champions[array_position].ap
	end

	def physical_attack(ad,defender)
		damage = @champions[defender].take_physical_damage(ad)
	end

	def magic_attack(ap,defender)
		damage = @champions[defender].take_magic_damage(ap)
	end

	# Returns an array of size 5 of bool
	def targets
		targets = Array.new
		@champions.each do |champ|
			targets << champ.is_dead
		end
		targets
	end

	# Returns a bool
	def check_defeat
		@champions.each do |champ|
			if champ.is_dead
				@standing = false
			end
		end
		@standing
	end

	# Returns an array of size 5 of integers
	def team_speed
		speed_arr = Array.new
		@champions.each do |champ|
			speed_arr << champ.ms
		end
		speed_arr
	end
	private
		# Returns an integer from 1-5
		def randomized_target(target_size)
			x = 1 + rand(100)
			case target_size
			when 1
				return 1
			when 2
				if (x <= 70)
					return 1
				else
					return 2
				end
			when 3
				if(x <= 55)
					return 1
				elsif(x <= 85)
					return 2
				else
					return 3
				end
			when 4
				if(x <= 50)
					return 1
				elsif(x <= 70)
					return 2
				elsif(x <= 80)
					return 3
				else
					return 4
				end
			when 5
				if(x <= 50)
					return 1
				elsif(x <= 75)
					return 2
				elsif(x <= 90)
					return 3
				elsif(x <= 98)
					return 4
				else
					return 5
				end					
			end
		end
end