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
		
		# debugger
		
		# continue only if hash and parameter exist
		if omniauth
			@authhash = Hash.new
			@authhash[:provider] = omniauth[:provider].to_s
			@authhash[:uid] = omniauth[:uid].to_s
			if service_route == 'facebook'
				@authhash[:name] = omniauth[:info][:name].to_s
				@authhash[:email] = omniauth[:info][:email].to_s
			elsif ['google', 'open_id'].index(service_route) != nil
				@authhash[:name] = omniauth[:info][:name].to_s
				@authhash[:email] = omniauth[:info][:email].to_s
			elsif service_route == 'qq_connect'
				@authhash[:name] = omniauth[:info][:name].to_s
				@authhash[:token] = omniauth[:credentials][:token].to_s
			elsif service_route = 'xiaonei'
				@authhash[:name] = omniauth[:info][:name].to_s
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
						# add new auth service to the current user
						@new_auth = current_user.services.create!(:provider => @authhash[:provider], :uid => @authhash[:uid])
						if @new_auth.save
							flash[:success] = 'Your ' + @authhash[:provider].capitalize + ' account has been connected to this site.'
						end
					end
					redirect_to current_user
				else
          			if auth
						sign_in auth.user
						redirect_to auth.user
						flash[:notice] = 'Signed in successfully via your ' + @authhash[:provider].capitalize + ' account.'
					elsif service_route != 'qq_connect' and service_route != 'xiaonei'
						user = User.find_by_email(@authhash[:email])
						if !user
							user = create_new_omniauth_user(@authhash)
						end
						user.services.create!(provider: @authhash[:provider], uid: @authhash[:uid])
						flash[:notice] = 'Sign up successfully via your ' + @authhash[:provider].capitalize + ' account.'
						sign_in user
						redirect_to user
					else
						session[:authhash] = @authhash
						redirect_to sign_up_path
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
	
	def create_new_omniauth_user(authhash)
		user = User.new
		user.apply_omniauth(authhash, true)
		debugger
		if user.save
			user
		else
			nil
		end
	end
end
