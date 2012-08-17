Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '275830165859773', '43bc9e3a7a14dfe69623c0070a32f600',
			{:scope => 'user_groups, friends_groups', :display => 'popup'}
end
