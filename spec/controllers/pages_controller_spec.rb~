require 'spec_helper'

describe PagesController do
	render_views

	describe "GET 'home'" do
		describe "when not signed in" do
			before do
				get :home
			end
			
			it "returns http success" do
				response.should be_success
			end
	
			it "should have the right title" do
				response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Home")
			end
		end
		
		describe "when signed in" do
			before do
				@user = FactoryGirl.create(:user)
				@other_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
				@other_user.follow!(@user)
			end
			
			it "should have the right follower/following counts" do
				# get :home
				# test_sign_in(@user) 
				# response.should have_selector("a", :href => following_user_path(@user),
				# :content => "0 following")
				# response.should have_selector("a", :href => followers_user_path(@user),
				# :content => "1 follower")
			end
		end
	end

	describe "GET 'club'" do
		before do
			get :club
		end
		it "returns http success" do
			response.should be_success
		end

		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Clubs")
		end
	end
	
	describe "GET 'about'" do
		before do
			get :about
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | About")
		end
	end
		
	describe "GET 'contact'" do
		before do
			get :contact
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Contact")
		end
	end
	
	describe "GET 'welcome'" do
		before do
			get :welcome
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Welcome")
		end
	end
	
	describe "GET 'handbook'" do
		before do
			get :handbook
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Handbook")
		end
	end
	
	describe "GET 'service'" do
		before do
			get :service
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Services")
		end
	end
	
	describe "GET 'news'" do
		before do
			get :news
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | News")
		end
	end
	
	describe "GET 'links'" do
		before do
			get :links
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Links")
		end
	end
	
	describe "GET 'art'" do
		before do
			get :art
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Art")
		end
	end
end
