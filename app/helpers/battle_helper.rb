module BattleHelper
	def render_log(log,battle,champions)
		event = log.event
		case event
		when "turn"
			return log_turn(log,battle,champions)
		when "end turn"
			return log_end_turn(log,battle,champions)
		when "health update"
			return log_hp_update(log,battle,champions)
		when "movespeed"
			return log_movespeed(log,battle,champions)
		when "attack order"
			return log_attack_order(log,battle,champions)
		when "range"
			return log_range(log,battle,champions)
		when "target selection"
			return log_target(log,battle,champions)
		when "out of range"
			return log_out_of_range(log,battle,champions)
		when "ability power"
			return log_ap(log,battle,champions)
		when "attack damage"
			return log_ad(log,battle,champions)
		when "magic resist"
			return log_mr(log,battle,champions)
		when "armor"
			return log_armor(log,battle,champions)
		when "damage"
			return log_damage(log,battle,champions)
		when "battle end check"
			return log_battle_end_check(log,battle,champions)
		when "determine exp"
			return log_determine_exp(log,battle,champions)
		when "level compare"
			return log_level_compare(log,battle,champions)
		when "exp gain"
			return log_exp_gain(log,battle,champions)
		when "grow level"
			return log_levelled_up(log,battle,champions)
		when "did not grow level"
			return log_did_not_level_up(log,battle,champions)
		when "post level"
			return log_post_level(log,battle,champions)
		when "post exp"
			return log_post_level(log,battle,champions)
		when "just died"
			return log_just_died(log,battle,champions)
		end
	end



	private
		def log_turn(log,battle,champions)
			return "<h2>Turn ##{log.extra.round}</h2>"
		end

		def log_end_turn(log,battle,champions)
			return ""		
		end

		def log_hp_update(log,battle,champions)
			# battle = Battle.find(log.battle_id)
			html = "<strong>Health Update:</strong><br>"
			html += "<table style=\"width: 300px\">"

			html += "<tr><td>"
			html += "#{champions[0].table_champion.name}: #{log.champ1.round}"
			html += "</td><td>"
			html += "#{champions[5].table_champion.name}: #{log.ochamp1.round}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[1].table_champion.name}: #{log.champ2.round}"
			html += "</td><td>"
			html += "#{champions[6].table_champion.name}: #{log.ochamp2.round}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[2].table_champion.name}: #{log.champ3.round}"
			html += "</td><td>"
			html += "#{champions[7].table_champion.name}: #{log.ochamp3.round}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[3].table_champion.name}: #{log.champ4.round}"
			html += "</td><td>"
			html += "#{champions[8].table_champion.name}: #{log.ochamp4.round}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[4].table_champion.name}: #{log.champ5.round}"
			html += "</td><td>"
			html += "#{champions[9].table_champion.name}: #{log.ochamp5.round}"
			html += "</td></tr>"


			html += "</table>"

		end

		def log_movespeed(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s movespeed is #{log.extra.round}<br>"
		end

		def log_attack_order(log,battle,champions)
			html = "<strong>Thus, the attack order is: </strong><br>"
			html += "#{champions[log.champ1.round].table_champion.name}<br>"
			html += "#{champions[log.champ2.round].table_champion.name}<br>"
			html += "#{champions[log.champ3.round].table_champion.name}<br>"
			html += "#{champions[log.champ4.round].table_champion.name}<br>"
			html += "#{champions[log.champ5.round].table_champion.name}<br>"
			html += "#{champions[log.ochamp1.round].table_champion.name}<br>"
			html += "#{champions[log.ochamp2.round].table_champion.name}<br>"
			html += "#{champions[log.ochamp3.round].table_champion.name}<br>"
			html += "#{champions[log.ochamp4.round].table_champion.name}<br>"
			html += "#{champions[log.ochamp5.round].table_champion.name}<br>"
		end

		def log_range(log,battle,champions)
			html = "<strong>Attack Ranges:</strong><br>"
			html += "#{champions[0].table_champion.name}: #{log.champ1.round}<br>"
			html += "#{champions[1].table_champion.name}: #{log.champ2.round}<br>"
			html += "#{champions[2].table_champion.name}: #{log.champ3.round}<br>"
			html += "#{champions[3].table_champion.name}: #{log.champ4.round}<br>"
			html += "#{champions[4].table_champion.name}: #{log.champ5.round}<br>"
			html += "#{champions[5].table_champion.name}: #{log.ochamp1.round}<br>"
			html += "#{champions[6].table_champion.name}: #{log.ochamp2.round}<br>"
			html += "#{champions[7].table_champion.name}: #{log.ochamp3.round}<br>"
			html += "#{champions[8].table_champion.name}: #{log.ochamp4.round}<br>"
			html += "#{champions[9].table_champion.name}: #{log.ochamp5.round}<br>"
		end

		def log_target(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s target is #{champions[log.extra.round].table_champion.name}<br>"
		end

		def log_out_of_range(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s range is #{log.extra.round}. There are #{log.other_champion_id.round} allys in front of him so he can't hit anyone.<br>"
		end

		def log_ap(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s ability power is #{log.extra.round}<br>"
		end

		def log_ad(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s attack damage is #{log.extra.round}<br>"
		end

		def log_damage(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name} dealt <b>#{log.extra.round}</b> damage to #{champions[log.other_champion_id].table_champion.name}<br>"
		end

		def log_mr(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s magic resist is #{log.extra.round}<br>"
		end

		def log_armor(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s armor is #{log.extra.round}<br>"
		end

		def log_battle_end_check(log,battle,champions)
			return "<br><br>"
		end

		def log_determine_exp(log,battle,champions)
			return ""
		end

		def log_level_compare(log,battle,champions)
			return ""
		end

		def log_exp_gain(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name} gained #{log.champ2.round} experience from #{log.champ1.round}-->#{log.extra.round}<br>"
		end

		def log_levelled_up(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name} levelled from #{log.champ1.round}-->#{log.extra.round}<br>"
		end

		def log_did_not_level_up(log,battle,champions)
			return ""
		end

		def log_post_level(log,battle,champions)
			return ""
		end

		def log_post_exp(log,battle,champions)
			return ""
		end

		def log_just_died(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name} has slain #{champions[log.other_champion_id].table_champion.name}.<br>"
		end
end
