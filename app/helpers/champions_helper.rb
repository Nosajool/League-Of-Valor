module ChampionsHelper
	def non_roster_hash(champs)
		champs_hash = Hash.new
		champs.each do |champ|
			champs_hash["#{champ.table_champion.name} Level: #{champ.level} ID: #{champ.id} Position: #{champ.position}"] = champ.id
		end
		champs_hash
	end

	def champ_list_hash
		champs_hash = Hash.new
		TableChampion.all.each do |champ|
			champs_hash["##{champ.id} #{champ.name}"] = champ.id
		end
		champs_hash
	end

	# Images
	def champ_img_square(champion)
		key = champion.table_champion.key
		image_tag("champions/#{key}/#{key}_Square_0.png", alt: "Champion Face", class: "champion_face")		
	end

	def champ_img_square_table(table_champion)
		key = table_champion.key
		image_tag("champions/#{key}/#{key}_Square_0.png", alt: "Champion Face", class: "champion_face")	
	end

	def champ_img_battle(champion)
		key = champion.table_champion.key
		image_tag("champions/#{key}/#{key}_#{champion.active_skin}.jpg")
	end

	def champ_img_splash(champion)
		key = champion.table_champion.key
		image_tag("champions/#{key}/#{key}_Splash_#{champion.active_skin}.jpg")
	end


	# Champion Statistics. Will calculate all stat boost (pros, buffs, roles) using the following methods

	def champ_hp(champion)
		health = champion.table_champion.hp + champion.level * champion.table_champion.hp_per_level
	end

	def champ_ad(champion)
		attack = champion.table_champion.attack_damage + champion.level * champion.table_champion.attack_damage_per_level
	end

	def champ_armor(champion)
		armor = champion.table_champion.armor + champion.level * champion.table_champion.armor_per_level
	end

	def champ_mr(champion)
		magic_resist = champion.table_champion.magic_resist + champion.level * champion.table_champion.magic_resist_per_level		
	end
end
