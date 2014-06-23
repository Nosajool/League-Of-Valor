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
end
