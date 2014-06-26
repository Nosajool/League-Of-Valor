class BattleChampion
	def initialize(champion)
		@hp = champ_hp(champion)
		@ad = champ_ad(champion)
		@ap = champ_ap(champion)
		@armor = champ_armor(champion)
		@mr = champ_mr(champion)
		@ms = champ_ms(champion)
		@level = champion.level
		@dead = false
	end

	def check_dead
		@dead = true if @hp <= 0
	end
end