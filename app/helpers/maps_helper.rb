module MapsHelper
	def map_picture_for(map_id)
		image_tag("maps/#{map_id}.jpg", alt: "Map", class: "mapImage")		
	end
end
