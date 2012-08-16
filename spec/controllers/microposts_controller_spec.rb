require 'spec_helper'

describe MicropostsController do
	render_views
	
	before do
		FactoryGirl.create(:weather)
	end
	
	describe "access control" do
		it "should deny access to 'create'" do
			post :create
			response.should redirect_to(sign_in_path)
		end
		it "should deny access to 'destroy'" do
			delete :destroy, :id => 1
			response.should redirect_to(sign_in_path)
		end
	end
	describe "POST 'create'" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			test_sign_in(@user)
		end
		describe "failure" do
			before(:each) do
				@attr = { :content => "" }
			end
			it "should not create a micropost" do
				lambda do
					post :create, :micropost => @attr
				end.should_not change(Micropost, :count)
			end
			it "should render the home page" do
				post :create, :micropost => @attr
				response.should redirect_to(@user)
			end
		end	
		describe "success" do
			before(:each) do
				@attr = { :content => "Lorem ipsum" }
			end
			it "should create a micropost" do
				lambda do
					post :create, :micropost => @attr
				end.should change(Micropost, :count).by(1)
			end
			it "should redirect to the home page" do
				post :create, :micropost => @attr
				response.should redirect_to(@user)
			end
			it "should have a flash message" do
				post :create, :micropost => @attr
				flash[:success].should =~ /micropost created/i
			end
		end
	end
	describe "DELETE 'destroy'" do
		describe "for an unauthorized user" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				wrong_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
				test_sign_in(wrong_user)
				@micropost = FactoryGirl.create(:micropost, :user => @user)
			end
			it "should deny access" do
				delete :destroy, :id => @micropost
				response.should redirect_to(@user)
			end
		end
		describe "for an authorized user" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				test_sign_in(@user)
				@micropost = FactoryGirl.create(:micropost, :user => @user)
			end
			it "should destroy the micropost" do
				lambda do
					delete :destroy, :id => @micropost
				end.should change(Micropost, :count).by(-1)
			end
		end
	end
end
