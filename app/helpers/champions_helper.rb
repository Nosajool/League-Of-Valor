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
		image_tag("#{pre_image_url}champions/#{key}/#{key}_Square_0.png", alt: "Champion Face", class: "champion_face")		
	end

	def champ_img_battle(champion)
		key = champion.table_champion.key
		image_tag("#{pre_image_url}champions/#{key}/#{key}_#{champion.active_skin}.jpg")
	end

	def champ_img_splash(champion)
		key = champion.table_champion.key
		image_tag("#{pre_image_url}champions/#{key}/#{key}_Splash_#{champion.active_skin}.jpg", class: "champion_banner")
	end


	# Champion Statistics. Will calculate all stat boost (pros, buffs, roles) using the following methods

	def champ_hp(champion)
		Rails.logger.debug "Finding hp for: #{champion.table_champion.name}"
		base = champion.table_champion.hp
		f_base = f_role(champion).hp_base
		s_base = s_role(champion).hp_base
		level = champion.level * champion.table_champion.hp_per_level
		per = 1
		f_per = f_role(champion).hp_per
		s_per = s_role(champion).hp_per
		health = base + f_base + s_base + level
		health = (health * (per + f_per + s_per)).round
	end

	def champ_ad(champion)
		Rails.logger.debug "Finding ad for: #{champion.table_champion.name}"
		base = champion.table_champion.attack_damage
		f_base = f_role(champion).ad_base
		s_base = s_role(champion).ad_base
		level = champion.level * champion.table_champion.attack_damage_per_level
		per = 1
		f_per = f_role(champion).ad_per
		s_per = s_role(champion).ad_per
		ad = base + f_base + s_base + level
		ad = (ad * (per + f_per + s_per)).round
	end

	def champ_ap(champion)
		Rails.logger.debug "Finding ap for: #{champion.table_champion.name}"
		# Ability power uses the same base attack damage
		base = champion.table_champion.attack_damage
		f_base = f_role(champion).ap_base
		s_base = s_role(champion).ap_base
		level = champion.level * champion.table_champion.attack_damage_per_level
		per = 1
		f_per = f_role(champion).ap_per
		s_per = s_role(champion).ap_per
		ap = base + f_base + s_base + level
		ap = (ap * (per + f_per + s_per)).round	
	end



	def champ_armor(champion)
		Rails.logger.debug "Finding armor for: #{champion.table_champion.name}"
		base = champion.table_champion.armor
		f_base = f_role(champion).ar_base
		s_base = s_role(champion).ar_base
		level = champion.level * champion.table_champion.armor_per_level
		per = 1
		f_per = f_role(champion).ar_per
		s_per = s_role(champion).ar_per
		armor = base + f_base + s_base + level
		armor = armor * (per + f_per + s_per)
	end

	def champ_mr(champion)
		Rails.logger.debug "Finding magic resist for: #{champion.table_champion.name}"
		base = champion.table_champion.magic_resist
		f_base = f_role(champion).mr_base
		s_base = s_role(champion).mr_base
		level = champion.level * champion.table_champion.magic_resist_per_level
		per = 1
		f_per = f_role(champion).mr_per
		s_per = s_role(champion).mr_per
		mr = base + f_base + s_base + level
		mr = mr * (per + f_per + s_per)	
	end

	def champ_ms(champion)
		Rails.logger.debug "Finding movespeed for: #{champion.table_champion.name}"
		base = champion.table_champion.movespeed
		f_base = f_role(champion).ms_base
		s_base = s_role(champion).ms_base
		per = 1
		f_per = f_role(champion).ms_per
		s_per = s_role(champion).ms_per
		ms = base + f_base + s_base
		ms = ms * (per + f_per + s_per)
	end

	def champ_range(champion)
		case champion.table_champion.attack_range
		when 125
			return 2
		when 150, 175
			return 3
		when 425, 450
			return 4
		when 475, 480
			return 5
		when 500, 525
			return 6
		when 550
			return 7
		when 575, 600
			return 8
		when 625, 650
			return 9
		else
			return 1
		end
	end

	private
		def f_role(champion)
			Rails.logger.debug "Checking Primary role for: #{champion.table_champion.name}"
			role = Role.where(name: champion.table_champion.f_role).first
		end

		def s_role(champion)
			Rails.logger.debug "Checking Secondary role for: #{champion.table_champion.name}"
			if champion.table_champion.s_role.nil?
				role = Role.where(name: "None").first
			else
				role = Role.where(name: champion.table_champion.s_role).first
			end
		end

		def pre_image_url
			"https://raw.githubusercontent.com/Nosajool/League-Of-Valor/images/"
		end
end
