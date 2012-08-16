require 'spec_helper'

describe OrganizationsController do
	render_views 
	
	before do
		FactoryGirl.create(:weather)
		@org = FactoryGirl.create(:organizations)
	end	
	
	describe "GET 'index'" do
		describe "for non-signed-in users" do
			before :each do
				@user = FactoryGirl.create(:user)
				get :index
			end
			it "should deny access" do
				response.should redirect_to(sign_in_path)
			end
		end
		describe "for signed-in users" do
			before do
				@user = FactoryGirl.create(:user)
				test_sign_in @user
				get :index
			end
			
			it "returns http success" do
				response.should be_success
			end
			it "should have the right title" do
				response.should have_selector("title", :content => "All clubs")
			end
		end
	end

	describe "GET 'new'" do
		describe "for non-signed-in users" do
			before do
				@user = FactoryGirl.create(:user)
				get :new
			end
			it "should deny access" do
				response.should redirect_to(sign_in_path)
			end
		end
		
		describe "for admin users" do
			before do
				@user = FactoryGirl.create(:user)
				@user.toggle!(:admin)
				test_sign_in @user
				get :new
			end
			it "returns http success" do
				response.should be_success
			end
			it "should have the right title" do
				response.should have_selector("title", :content => "New club")
			end
		end
	end

	# describe "GET 'create'" do
		# it "returns http success" do
			# get 'create'
			# response.should be_success
		# end
	# end
# 
	# describe "GET 'edit'" do
		# it "returns http success" do
			# get 'edit'
			# response.should be_success
		# end
	# end
# 
	# describe "GET 'update'" do
		# it "returns http success" do
		  # get 'update'
		  # response.should be_success
		# end
	# end

	describe "GET 'show'" do
		before do
			@user = FactoryGirl.create(:user)
		end
		describe "when not signed in" do
			it "should deny access" do
				get :show, :id => @org
				response.should redirect_to sign_in_path
			end
		end
		
		describe "when signed in" do
			before do
				test_sign_in @user
			end
			it "should be success" do
				get :show, :id => @org
				response.should be_success
			end
		end
	end

	describe "DELETE 'destroy'" do
		before do
			@user = FactoryGirl.create(:user)
		end
		describe "as a non-signed-in user" do
			it "should deny access" do
				delete :destroy, :id => @org
				response.should redirect_to(sign_in_path)
			end
		end
		describe "as a non-admin" do
			before do
				test_sign_in @user
			end
			it "should deny access" do
				delete :destroy, :id => @org
				response.should redirect_to(sign_in_path)
			end
		end
		describe "as an admin user" do
			before do             
				@user.toggle!(:admin)
				test_sign_in @user
			end
			it "should destroy the club" do
				lambda do
					delete :destroy, :id => @org
				end.should change(Organizations, :count).by(-1)
			end
		end
	end
end
