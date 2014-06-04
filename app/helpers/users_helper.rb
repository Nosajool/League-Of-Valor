module UsersHelper

	# Summoner Icon helper
	def icon_for(user, options = { size: "m" } )
		size = options[:size]
		image_tag("icons/icons_#{size}/#{user.icon}.jpg", alt: "Summoner Icon", class: "summoner_icon")
	end

	# Champ Face Helper
	def champ_face_for(champ_id, options = { size: "m" } )
		size = options[:size]
		image_tag("champ_faces/champ_faces_#{size}/#{champ_id}.jpg", alt: "Champion Face", class: "champion_face")		
	end

end