module StaticPagesHelper

	# Renders a link to the github issue that has been fixed in this patch
	def git_issue(num)
		return "<li><a href=\"https://github.com/Nosajool/League-Of-Valor/issues/#{num}\" id = \"issues\">\##{num}</a></li>".html_safe
	end
end
