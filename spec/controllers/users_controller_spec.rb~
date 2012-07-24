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
	
	describe "GET 'show'" do
		render_views
		
		before(:each) do
			@user = Factory(:user)
		end
		
		it "should be success" do
			get :show, :id => @user
			response.should be_success
		end
		
		it "should find the right user" do
			get :show, :id => @user
			assigns(:user).should == @user
		end
		
		it "should have the right title" do
			get :show, :id => @user
			response.should have_selector("title", :content => @user.name)
		end
		
		it "should include the user's name" do
			get :show, :id => @user
			response.should have_selector("h1", :content => @user.name)
		end
		
		it "should have a profile image" do
			get :show, :id => @user
			response.should have_selector("h1>img", :class => "gravatar")
		end
	end

end
