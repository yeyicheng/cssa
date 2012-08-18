class ServicesController < ApplicationController

	# before_filter :authenticate, :except => [:create]
	protect_from_forgery :except => :create     # see https://github.com/intridea/omniauth/issues/203
	
	def index
		# get all authentication services assigned to the current user
		@services = current_user.services.all
	end
	
	def destroy
		# remove an authentication service linked to the current user
		@service = current_user.services.find(params[:id])
		@service.destroy
		redirect_to sign_in_path
	end

	def create
		
		# get the service parameter from the Rails router
		service_route = params[:provider] || 'no service (invalid callback)'
		
		# get the full hash from omniauth
		omniauth = request.env['omniauth.auth']
		
		debugger
		
		# continue only if hash and parameter exist
		if omniauth
			@authhash = Hash.new
    
			if service_route == 'facebook'
				@authhash[:provider] = omniauth['provider'].to_s
				@authhash[:uid] = omniauth['uid'].to_s
				@authhash['info']['email'] = omniauth['info']['email'].to_s
				@authhash['info']['name'] = omniauth['info']['name'].to_s
				@authhash['extra']['raw_info']['id'] = omniauth['extra']['raw_info']['id'].to_s
			else
				# unrecognized service, output the hash that has been returned
				render :text => omniauth.to_yaml
				return
			end
			# continue only if provider and uid exist
			if @authhash[:uid] != '' and @authhash[:provider] != ''
				auth = Service.find_by_provider_and_uid(@authhash[:provider], @authhash[:uid])
				if signed_in?
					if auth
						flash[:notice] = 'Your account at ' + @authhash[:provider].capitalize + ' is already connected with this site.'
					else
						@new_auth = current_user.services.build(:provider => @authhash[:provider], :uid => @authhash[:uid])
						if @new_auth.save
							flash[:success] = 'Your ' + @authhash[:provider].capitalize + ' account has been connected to this site.'
						end
					end
					redirect_to root_path
				else
          			if auth
          				session[:user_id] = auth.user.id
          				session[:identity_id] = auth.id
						sign_in auth.user
						flash[:notice] = 'Signed in successfully via ' + @authhash[:provider].capitalize + '.'
					else
						# this is a new user; show signup; @authhash is available to the view and stored in the sesssion for creation of a new user
						session[:authhash] = @authhash
						render sign_up_path
					end
				end
			else
				flash[:error] =  'Error while authenticating via ' + service_route + '/' + @authhash[:provider].capitalize + '. Service returned invalid data.'
				redirect_to sign_in_path
			end
		else
			flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '. Service did not return valid data.'
			redirect_to sign_in_path
		end
	end
	
	def failure
		flash[:error] = 'There was an error at the remote authentication service. You have not been signed in.'
		redirect_to sign_in_path
	end
end
