module UsersHelper

	# Summoner Icon helper
	def icon_for(user, options = { size: "m" } )
		size = options[:size]
		image_tag("icons/icons_#{size}/#{user.icon}.jpg", alt: "Summoner Icon", class: "summoner_icon")
	end

end