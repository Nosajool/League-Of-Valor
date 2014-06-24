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

	# Champ Face Helper
	def champ_face_for(riot_id)
		image_tag("champ_faces/#{riot_id}_Web_0.jpg", alt: "Champion Face", class: "champion_face")		
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
