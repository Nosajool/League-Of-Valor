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
	attr_reader :id

		def initialize(champion,battle_id)
			@hp = champ_hp(champion)
			@ad = champ_ad(champion)
			@ap = champ_ap(champion)
			@armor = champ_armor(champion)
			@mr = champ_mr(champion)
			@ms = champ_ms(champion)
			@level = champion.level
			@id = champion.id
			@dead = false
			@experience = champion.experience
			@name = skin_title(champion)
			@range = champ_range(champion)
			@battle_id = battle_id
			@dead_log = false
		end

		def is_dead
			if @hp <= 0
				@hp = 0
				@dead = true
			end
			@dead
		end 

		def just_died?
			if !@dead_log && @hp <= 0
				@dead_log = true
				return true
			else
				return false
			end
		end

		def exp_reward(event_num,x)
			reward = ((@hp + @ad + @ap + @armor + @mr) /5).round
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: event_num,
				event: "determine exp",
				champion_id: x,
				extra: reward
			})
			return reward
		end

		def gain_exp(exp,event_num,x)
			old_exp = @experience
			@experience += exp
			BattleLog.create!({
				battle_id: @battle_id,
				event_num: event_num,
				event: "exp gain",
				champion_id: x,
				extra: @experience,
				champ1: old_exp,
				champ2: exp
			})
			event_num += 1
			update_level(event_num,x)
		end

		def take_physical_damage(opp_ad)
			# Actual Battle
			multiplier = 100 / (100 + @armor)
			damage =  (multiplier * opp_ad).ceil
			
			Rails.logger.debug "opp_ad: #{opp_ad} type: #{opp_ad.class}"
			Rails.logger.debug "health: #{@hp} type: #{@hp.class}"
			@hp = @hp - damage
			return damage
		end

		def take_magic_damage(opp_ap)
			# Actual Battle
			multiplier = 100 / (100 + @mr)
			damage = (multiplier * opp_ap).ceil
			
			Rails.logger.debug "opp_ap: #{opp_ap} type: #{opp_ap.class}"
			Rails.logger.debug "health: #{@hp} type: #{@hp.class}"
			@hp = (@hp - damage).round
			return damage
		end

		def update_champion_stats(event_num,x)
			update_exp_level(event_num,x)			
		end

		private
			def update_level(event_num,x)
				new_level = Math.cbrt(@experience)
				Rails.logger.debug "Name: #{@name} Update Level Check: #{new_level.round} from level #{@level}"
				BattleLog.create!({
					battle_id: @battle_id,
					event_num: event_num,
					event: "level compare",
					champion_id: x,
					extra: new_level,
					champ1: @level
				})
				event_num += 1
				if(new_level.round != @level)
					Rails.logger.debug "Name: #{@name} grew to #{new_level.round} from level #{@level}"
					BattleLog.create!({
						battle_id: @battle_id,
						event_num: event_num,
						event: "grow level",
						champion_id: x,
						extra: new_level.round,
						champ1: @level
					})
					@level = new_level.round
				else
					BattleLog.create!({
						battle_id: @battle_id,
						event_num: event_num,
						event: "did not grow level",
						champion_id: x,
						extra: new_level.round,
						champ1: @level
					})
					Rails.logger.debug "#{@name} did not grow a level"					
				end
			end

			def update_exp_level(event_num,x)
					@champion = Champion.find(@id)
					BattleLog.create!({
						battle_id: @battle_id,
						event_num: event_num,
						event: "post exp",
						champion_id: x,
						extra: @experience
					})
					@champion.experience = @experience
					event_num += 1
					BattleLog.create!({
						battle_id: @battle_id,
						event_num: event_num,
						event: "post level",
						champion_id: x,
						extra: @level
					})
					@champion.level = @level
					@champion.save
			end
end