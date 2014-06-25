module TableChampionsHelper

	def table_champ_img_square(table_champion)
		key = table_champion.key
		image_tag("champions/#{key}/#{key}_Square_0.png", alt: "Champion Face", class: "champion_face")	
	end

end
