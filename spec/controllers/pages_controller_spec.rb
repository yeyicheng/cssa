require 'spec_helper'

describe PagesController do
	render_views

	describe "GET 'home'" do
		describe "when not signed in" do
			before (:each) do
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
			before (:each) do
				@user = FactoryGirl.create(:user)
				test_sign_in @user 
				@other_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
				@other_user.follow!(@user)
			end
			
			it "should have the right follower/following counts" do
				get :home
				response.should have_selector("a", :href => following_user_path(@user),
				:content => "0 following")
				response.should have_selector("a", :href => followers_user_path(@user),
				:content => "1 follower")
			end
		end
	end

	describe "GET 'club'" do
		before (:each) do
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
		before (:each) do
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
		before (:each) do
			get :contact
		end
		
		it "returns http success" do
			response.should be_success
		end
		
		it "should have the right title" do
			response.should have_selector("title", :content => "Chinese Student and Scholar Association of UMCP | Contact")
		end
	end
end
