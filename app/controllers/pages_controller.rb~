
class PagesController < ApplicationController
	def home
		@title = 'Home'
		if signed_in?
			store_location
			@micropost = Micropost.new
			@user = current_user
			@feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 5)
		end
	end
  
	def contact
		@title = 'Contact'
	end
  
	def about
		@title = 'About'
	end
  
	def sign_in
		@title = 'Sign in'
	end
	
	def welcome
		@title = 'Welcome'
	end
  
	def service
		@title = 'Services'
	end
  
	def handbook
		@title = 'Handbook'
	end
  
	def news
		@title = 'News'
	end
	
	def links
		@title = 'Links'
	end
	
	def art
		@title = 'Art'
	end
end
