
module PagesHelper
	def	createShowPage (parent, children, new, back) 
		@user = current_user
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 8)

		render :partial => 'shared/show_page', 
			:locals => {:feed_items => @feed_items, :user => @user, :micropost => @micropost, 
			:parent => parent, :children => children, :new => new, :back => back
		}
	end
	
	def createUserPanel
		@user = current_user
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:feed_page], :per_page => 8)
		
		render :partial => 'shared/user_info_feeds', 
		:locals => {:feed_items => @feed_items, :user => @user, :micropost => @micropost}
	end
	
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
