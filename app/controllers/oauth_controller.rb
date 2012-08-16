class OauthController < ApplicationController
	def start
		redirect_to client.web_server.authorize_url(
			# :client_id => '275830165859773',
			:redirect_uri => '/art', 
			:scope =>['user_groups', 'friends_groups']
		)
	end
	
	def callback
		access_token = client.web_server.get_access_token(
			params[:code], :redirect_uri => '/art'
		)
		
		session[:fb_user] = JSON.parse access_token.get('/me')
		
		redirect_to :controller => :users, :action => :login_process_facebook, :token => access_token.token
	end
	
	protected
	
	def client
		facebook_settings = YAML::load(File.open("config/oauth.yml"))
		@client ||= OAuth2::Client.new(
			"#{facebook_settings[RAILS_ENV]['275830165859773']}", "#{facebook_settings[RAILS_ENV]['43bc9e3a7a14dfe69623c0070a32f600']}",
			:site => 'http://hollow-waterfall-1839.herokuapp.com'
		)
	end
end
