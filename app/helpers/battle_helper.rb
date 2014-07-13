module BattleHelper
	def render_log(log,battle,champions)
		event = log.event
		case event
		when "turn"
			return log_turn(log,battle,champions)
		when "health update"
			return log_hp_update(log,battle,champions)
		when "target selection"
			return log_target(log,battle,champions)
		when "ability power"
			return log_ap(log,battle,champions)
		when "attack damage"
			return log_ad(log,battle,champions)
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
		end
	end



	private
		def log_turn(log,battle,champions)
			return "<h2>Turn ##{log.extra.round}</h2>"
		end

		def log_hp_update(log,battle,champions)
			# battle = Battle.find(log.battle_id)
			html = "<strong>Health Update:</strong><br>"
			html += "<table border="">"

			html += "<tr><td>"
			html += "#{champions[0].table_champion.name}: #{log.champ1}"
			html += "</td><td>"
			html += "#{champions[5].table_champion.name}: #{log.ochamp1}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[1].table_champion.name}: #{log.champ2}"
			html += "</td><td>"
			html += "#{champions[6].table_champion.name}: #{log.ochamp2}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[2].table_champion.name}: #{log.champ3}"
			html += "</td><td>"
			html += "#{champions[7].table_champion.name}: #{log.ochamp3}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[3].table_champion.name}: #{log.champ4}"
			html += "</td><td>"
			html += "#{champions[8].table_champion.name}: #{log.ochamp4}"
			html += "</td></tr>"

			html += "<tr><td>"
			html += "#{champions[4].table_champion.name}: #{log.champ5}"
			html += "</td><td>"
			html += "#{champions[9].table_champion.name}: #{log.ochamp5}"
			html += "</td></tr>"


			html += "</table>"

		end

		def log_target(log,battle,champions)
			return "#{champions[log.champion_id].table_champion.name}'s target is #{champions[log.extra.round].table_champion.name}"
		end

		def log_ap(log,battle,champions)
			"ap"
		end

		def log_ad(log,battle,champions)
			"ad"
		end

		def log_damage(log,battle,champions)
			"dmg"
		end

		def log_battle_end_check(log,battle,champions)
			"end"
		end

		def log_determine_exp(log,battle,champions)
			"det exp"
		end

		def log_level_compare(log,battle,champions)
			"level compare"
		end

		def log_exp_gain(log,battle,champions)
			"exp gain"
		end

		def log_levelled_up(log,battle,champions)
			"levelled up"
		end

		def log_did_not_level_up(log,battle,champions)
			"not levelled up"
		end

		def log_post_level(log,battle,champions)
			"post level"
		end

		def log_post_exp(log,battle,champions)
			"post exp"
		end
end
