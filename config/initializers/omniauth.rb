# OmniAuth.config.full_host = "http://hollow-waterfall-1839.herokuapp.com"
# Rails.application.config.middleware.use OmniAuth::Builder do
	# provider :facebook, '275830165859773', '43bc9e3a7a14dfe69623c0070a32f600',
	# {:scope => 'user_groups,friends_groups', :display => 'popup', :callback_path => '/' }
# end

Rails.application.config.middleware.use OmniAuth::Builder do
	require 'openid/store/filesystem'
	
	fb_id = '275830165859773'
	fb_secret = '43bc9e3a7a14dfe69623c0070a32f600'
	fb_test_id = '276626282442340' 
	fb_test_secret = '1dc252792ddcd14369b654499d860f36'
	
	provider :facebook, fb_id, fb_secret
	{ scope: 'email, user_groups,friends_groups', display: 'popup' }
	
	provider :openid, store: OpenID::Store::Filesystem.new('./tmp'), name: 'openid'
	
	provider :openid, store: OpenID::Store::Filesystem.new('./tmp'), name: 'google', identifier: 'https://www.google.com/accounts/o8/id'

	provider :google_oauth2, '417403064618.apps.googleusercontent.com', 'CqemGzl3Gk8rzIBuxrCxKG7B', 
	{ scope: 'userinfo.email,userinfo.profile', access_type: 'online', approval_prompt: '' }
end                                                                       
