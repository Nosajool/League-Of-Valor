def full_title(page_title)
	base_title = "Vion Genesis"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end	
end