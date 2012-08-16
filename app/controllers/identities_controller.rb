class IdentitiesController < ApplicationController

	before_filter :authenticate, :except => [:create]

	def index
		# get all authentication services assigned to the current user
		@services = current_user.identities.all
	end
	
	def destroy
		# remove an authentication service linked to the current user
		@service = current_user.identities.find(params[:id])
		@service.destroy
		
		redirect_to identities_path
	end

	def create
		# get the service parameter from the Rails router
		params[:service] ? service_route = params[:service] : service_route = 'no service (invalid callback)'
		
		# get the full hash from omniauth
		omniauth = request.env['omniauth.auth']
		
		# continue only if hash and parameter exist
		if omniauth and params[:service]
    
			# map the returned hashes to our variables first - the hashes differ for every service
			if service_route == 'facebook'
				omniauth['extra']['user_hash']['email'] ? email =  omniauth['extra']['user_hash']['email'] : email = ''
				omniauth['extra']['user_hash']['name'] ? name =  omniauth['extra']['user_hash']['name'] : name = ''
				omniauth['extra']['user_hash']['id'] ?  uid =  omniauth['extra']['user_hash']['id'] : uid = ''
				omniauth['provider'] ? provider =  omniauth['provider'] : provider = ''
			else
				# we have an unrecognized service, just output the hash that has been returned
				render :text => omniauth.to_yaml
				#render :text => uid.to_s + " - " + name + " - " + email + " - " + provider
				return
			end
  
		# continue only if provider and uid exist
		if uid != '' and provider != ''
        
			# nobody can sign in twice, nobody can sign up while being signed in (this saves a lot of trouble)
			if !signed_in?
        
				# check if user has already signed in using this service provider and continue with sign in process if yes
				auth = Identity.find_by_provider_and_uid(provider, uid)
				if auth
					flash[:notice] = 'Signed in successfully via ' + provider.capitalize + '.'
					sign_in auth.user
					redirect_back_or auth.user
				else
					# check if this user is already registered with this email address; get out if no email has been provided
					if email != ''
					# search for a user with this email address
						existinguser = User.find_by_email(email)
						if existinguser
							# map this new login method via a service provider to an existing account if the email address is the same
							existinguser.identities.create(:provider => provider, :uid => uid)
							flash[:notice] = 'Sign in via ' + provider.capitalize + ' has been added to your account ' + existinguser.email + '. Signed in successfully!'
							sign_in existinguser
							redirect_back_or existinguser
						else

							# new user, set email, a random password and take the name from the authentication service
							user = User.new :name => name, :email => email, :password => SecureRandom.hex(10), :password_confirmation => :password
							
							# add this authentication service to our new user
							user.identities.build(:provider => provider, :uid => uid)
							
							# do not send confirmation email, we directly save and confirm the new record
							user.skip_confirmation!
							user.save!
							user.confirm!

							# flash and sign in
							flash[:success] = 'Your account on CommunityGuides has been created via ' + provider.capitalize + '. In your profile you can change your personal information and add a local password.'
							sign_in user
							redirect_back_or(user)
						end
					else
						flash[:error] =  service_route.capitalize + ' can not be used to sign-up on CommunityGuides as no valid email address has been provided. Please use another authentication provider or use local sign-up. If you already have an account, please sign-in and add ' + service_route.capitalize + ' from your profile.'
						redirect_to sign_in_path
					end
				end
			else
				# the user is currently signed in
        		auth = Identity.find_by_provider_and_uid(provider, uid)
				if !auth
					current_user.identities.create(:provider => provider, :uid => uid)
					flash[:notice] = 'Sign in via ' + provider.capitalize + ' has been added to your account.'
					redirect_to identities_path
				else
					flash[:notice] = service_route.capitalize + ' is already linked to your account.'
					redirect_to identities_path
				end  
			end  
		else
			flash[:error] =  service_route.capitalize + ' returned invalid data for the user id.'
			redirect_to sign_in_path
		end
	else
		flash[:error] = 'Error while authenticating via ' + service_route.capitalize + '.'
		redirect_to sign_in_path
	end
end
