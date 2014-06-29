class BattleChampion
	attr_reader :hp
	attr_reader :ad
	attr_reader :ap
	attr_reader :armor
	attr_reader :mr
	attr_reader :ms
	attr_reader :level
	attr_reader :experience
	attr_reader :name
	attr_reader :range

		def initialize(champion)
			@hp = champ_hp(champion)
			@ad = champ_ad(champion)
			@ap = champ_ap(champion)
			@armor = champ_armor(champion)
			@mr = champ_mr(champion)
			@ms = champ_ms(champion)
			@level = champion.level
			@dead = false
			@experience = champion.experience
			@name = skin_title(champion)
			@range = champ_range(champion)
		end

		def is_dead
			@dead = true if @hp <= 0
			@dead
		end

		def take_physical_damage(opp_ad)
			multiplier = 100 / (100 + @armor)
			@health = @health - (multiplier * opp_ad).ceil
		end

		def take_magic_damage(opp_ap)
			multiplier = 100 / (100 + @mr)
			@health = @health - (multiplier * opp_ap).ceil
		end
end