
class PagesController < ApplicationController
	def home
		@title = 'Home'
		@micropost = Micropost.new if signed_in?
		@user = current_user if signed_in?
	end
  
	def club
		@title = 'Clubs'
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
end
