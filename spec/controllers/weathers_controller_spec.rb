require 'spec_helper'

describe WeathersController do
	render_views
	
	before do
		@weather = FactoryGirl.create(:weather)
	end
	
	describe "GET index" do
		describe "not signed in" do
			before do
				get :index
			end
			it "should deny access" do
				response.should redirect_to sign_in_path
			end
		end
		
		describe "signed in" do
			before do
				@user = FactoryGirl.create(:user)
				test_sign_in @user
			end
			it "should have the correct title" do
				get :index
				response.should have_selector("title", :content => 'Weather')
			end
		end
	end
end
