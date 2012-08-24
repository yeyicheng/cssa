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
			image_tag 'rails.png', :size => @size, :alt => user[:name], class: 'avatar'
		else	
			image_tag user.avatar.url(size), :alt => user[:name], class: 'avatar'
		end
	end
	
	def html_safe_(text)
       return text if text.nil?
       return text.html_safe if defined?(ActiveSupport::SafeBuffer)
       return text.html_safe! if text.respond_to?(:html_safe!)
       text
   end
end
