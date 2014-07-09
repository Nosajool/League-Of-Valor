module UsersHelper

	# Summoner Icon helper
	def icon_for(user, options = { size: "m" } )
		size = options[:size]
		image_tag("icons/icons_#{size}/#{user.icon}.jpg", alt: "Summoner Icon", class: "summoner_icon")
	end

	def icon_hash
		icon_path = (Rails.root.join('app', 'assets', 'images', 'icons', 'icons_m')).to_s
		num_icons = Dir.glob(File.join(icon_path, '**', '*')).select { |file| File.file?(file) }.count
		icon_hash = Hash.new
		for x in 1..num_icons
			icon_hash["##{x}"] = x
		end
		icon_hash
	end

end