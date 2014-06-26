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

		def check_dead
			@dead = true if @hp <= 0
			@dead
		end

		def method_name
			
		end
	private
end