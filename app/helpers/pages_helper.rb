
module PagesHelper
	# def getFeed
		# client = OAuth2::Client.new('275830165859773', '43bc9e3a7a14dfe69623c0070a32f600', :site => 'http://hollow-waterfall-1839.herokuapp.com/')
	# 
		# client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth2/callback')
		# # => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"
		# 
		# token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:3000/oauth2/callback')
		# response = token.get('/art')
		# response.parsed	 
	# end
	def getFBGroupFeed	
		 token = '275830165859773|Aa4BPDQPUG8CRf_XRj2zzzU9Ptc'
		 base_url = 'https://graph.facebook.com/'
		 group_id = '269319572867'
		 uri = URI(base_url << group_id << '/feed')
		 uri = URI('https://graph.facebook.com/269319572867/feed')
		 params = {:access_token => token}
		 uri.query = URI.encode_www_form(params)
		 
		 http = Net::HTTP.new(uri.host, uri.port)
		 http.use_ssl = true
		 http.verify_mode = OpenSSL::SSL::VERIFY_NONE  #You should use VERIFY_PEER in production
		 request = Net::HTTP::Get.new(uri.request_uri)
		 res = http.request(request)
		 
		 data = res.body if res.is_a?(Net::HTTPSuccess)
		 
		 results = JSON.parse(data)
		 
		 if results.has_key? 'error'
			 raise 'Web service error'
		 end
		 
		 results
	 end
end
