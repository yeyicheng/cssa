
class SessionsController < ApplicationController
	def new
		@title = "Sign in"
	end
	
	def create
		user = User.authenticate(params[:session][:email], params[:session][:password])
		auth = auth_hash
		if user.nil?
			flash.now[:error] = "Invalid email/password combination."
			@title = 'Sign in'
			render 'new'
		elsif !auth.nil?
			identity = Identity.find_by_provider_and_uid(auth[:provider], auth[:uid])
			session[:identity_id] = identity.id
		else
			session[:user_id] = user.id
			sign_in user
			redirect_back_or user
		end
	end
	
	def destroy
		sign_out
		redirect_to root_path
	end
	
	protected

	def auth_hash
		request.env['omniauth.auth']
	end
end
