
class SessionsController < ApplicationController
	def new
		@title = "Sign in"
	end
	
	def create
		@title = "Sign in"
		user = User.authenticate(params[:session][:email], params[:session][:password])
		if user.nil?
			# Create an error message and re-render the signin form.
			flash.now[:error] = "Invalid email/password combination."
			render 'new'
		else
			# Sign the user in and redirect to the user's show page.
			redirect_to user
		end
	end
	
	def destroy
		
	end
end
