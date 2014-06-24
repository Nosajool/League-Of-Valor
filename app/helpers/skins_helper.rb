module SkinsHelper
	def skin_title(champion)
		skin_name = champion.table_champion.skins.where(num: champion.active_skin).first.name
		if skin_name == "default"
			return champion.table_champion.name
		else
			return skin_name
		end
	end
end
