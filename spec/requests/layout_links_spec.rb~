require 'spec_helper'

describe "LayoutLinks" do

	describe "GET /layout_links" do
		it "should have a Home page at '/'" do
			get '/'
			response.should have_selector('title', :content => "Home")
		end
		it "should have a Clubs page at '/club'" do
			get '/club'
			response.should have_selector('title', :content => "Clubs")
		end
		it "should have an About page at '/contact'" do
			get '/contact'
			response.should have_selector('title', :content => "Contact")
		end
		it "should have an Contact page at '/about'" do
			get '/about'
			response.should have_selector('title', :content => "About")
		end
		it "should have a signup page at '/sign_up'" do
			get '/sign_up'
			response.should have_selector('title', :content => "Sign up")
		end
		it "should have a signup page at '/sign_in'" do
			get '/sign_in'
			response.should have_selector('title', :content => "Sign in")
		end
	end
	
	describe "when not signed in" do
		it "should have a signin link" do
			visit root_path
			response.should have_selector("a", :href => sign_in_path,
			:content => "Sign in")
		end
	end
	describe "when signed in" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			visit sign_in_path
			fill_in :email, :with => @user.email
			fill_in :password, :with => @user.password
			click_button
		end
		it "should have a signout link" do
			visit root_path
			response.should have_selector("a", :href => sign_out_path,
			:content => "Sign out")
		end
		it "should have a profile link" do
			visit root_path
			response.should have_selector("a", :href => user_path(@user),
			:content => "Profile")
		end
	end
	describe "sign in/out" do
		describe "failure" do
			it "should not sign a user in" do
				visit sign_in_path
				fill_in :email, :with => ""
				fill_in :password, :with => ""
				click_button
				response.should have_selector("div.flash.error", :content => "Invalid")
			end
		end
		describe "success" do
			it "should sign a user in and out" do
				user = FactoryGirl.create(:user)
				visit sign_in_path
				fill_in :email, :with => user.email
				fill_in :password, :with => user.password
				click_button
				controller.should be_signed_in
				visit root_path
				click_link "Sign out"
				controller.should_not be_signed_in
			end
		end
	end
end
