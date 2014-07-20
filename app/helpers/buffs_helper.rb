module BuffsHelper

	def buff_img(buff)
		id = buff.id
		image_tag("#{pre_image_url}buffs/#{id}.png", alt: "Buff Image")		
	end

	private
		def pre_image_url
			"https://raw.githubusercontent.com/Nosajool/League-Of-Valor/images/"
		end
end
