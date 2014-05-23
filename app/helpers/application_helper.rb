module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = "Vion Genesis"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	# Bootstrap 4 changed names
	def bootstrap_class_for(flash_type)
	    case flash_type
	      when "success"
	        "alert-success"   # Green
	      when "error"
	        "alert-danger"    # Red
	      when "alert"
	        "alert-warning"   # Yellow
	      when "notice"
	        "alert-info"      # Blue
	      else
	        flash_type.to_s
	    end
  	end
end
