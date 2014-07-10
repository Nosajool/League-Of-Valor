module TableChampionsHelper

	def table_champ_img_square(table_champion)
		key = table_champion.key
		image_tag("#{pre_image_url}champions/#{key}/#{key}_Square_0.png", alt: "Champion Face", class: "champion_face")	
	end

	private
		def pre_image_url
			"https://raw.githubusercontent.com/Nosajool/League-Of-Valor/images/"
		end

end
