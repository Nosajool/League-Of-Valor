class BattleChampion
	include ChampionsHelper
	include SkinsHelper

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
			# Actual Battle
			# multiplier = 100 / (100 + @armor)
			#damage =  (multiplier * opp_ad).ceil
			
			# Simplified Battle
			Rails.logger.debug "opp_ad: #{opp_ad} type: #{opp_ad.class}"
			damage = opp_ad
			Rails.logger.debug "health: #{@hp} type: #{@hp.class}"
			@hp = @hp - damage
			return damage
		end

		def take_magic_damage(opp_ap)
			# Actual Battle
			# multiplier = 100 / (100 + @mr)
			# damage = (multiplier * opp_ap).ceil
			
			# Simplified Battle 
			Rails.logger.debug "opp_ap: #{opp_ap} type: #{opp_ap.class}"
			damage = opp_ap
			Rails.logger.debug "health: #{@hp} type: #{@hp.class}"
			@hp = (@hp - damage).round
			return damage
		end
end