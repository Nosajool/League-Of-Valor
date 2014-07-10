module MapsHelper
	def map_picture_for(map_id)
		image_tag("#{pre_image_url}maps/#{map_id}.jpg", alt: "Map", class: "mapImage")	
	end

	private
		def pre_image_url
			"https://raw.githubusercontent.com/Nosajool/League-Of-Valor/images/"
		end
end
