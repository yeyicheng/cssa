module ApplicationHelper
	def title
		base_title = "Chinese Student and Scholar Association of UMCP"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	
	def avatar_for (user, size)
		if user.avatar.url.end_with? 'missing.png'
			@size = user.avatar.options[:styles][size][0..-2]
			image_tag 'rails.png', :size => @size
		else	
			image_tag user.avatar.url(size)
		end
	end
end
