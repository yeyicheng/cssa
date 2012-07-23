require 'spec_helper'

describe UsersController do
  
	describe "GET 'new'" do
		render_views
		
		it "returns http success" do
			get 'new'
			response.should be_success
		end
		
		it "should have the right title" do
			get 'new'
			response.should have_selector("title", :content => "Sign up")
		end
	end

	describe "GET 'index'" do
		render_views
		
		it "returns http success" do
			get 'index'
			response.should be_success
		end
		
		it "should have the right title" do
			get 'index'
			response.should have_selector("title", :content => "Users")
		end
	end
	
	#~ describe "GET 'show'" do
		#~ render_views
		#~ 
		#~ it "returns http success" do
			#~ get 'show'
			#~ response.should be_success
		#~ end
		#~ 
		#~ it "should have the right title" do
			#~ get 'show'
			#~ response.should have_selector("title", :content => User.find(params[:id])[:name])
		#~ end
	#~ end

end
