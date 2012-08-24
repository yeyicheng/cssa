
class PagesController < ApplicationController
	def home
		@title = 'Home'
		if signed_in?
			store_location
			@micropost = Micropost.new
			@user = current_user
			@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 5)
		end
		@data = fetchPostData
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
	
	def welcome_ch
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
		if signed_in?
			@micropost = Micropost.new
			@user = current_user
			@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 5)
		end
	end
	
	def art
		@title = 'Art'
		@results = getFBGroupFeed['data']
	end
end
