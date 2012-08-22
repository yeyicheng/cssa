require 'spec_helper'

describe OrganizationsController do
	render_views 
	
	before do
		FactoryGirl.create(:weather)
	end	
	
	describe "GET 'new'" do
		describe "for non-signed-in and non-admin users" do
			before do
				@user = FactoryGirl.create(:user)
				get :new
			end
			it "should deny access for non-signed-in" do
				response.should redirect_to(root_path)
			end
			it 'should deny access for non-admin' do
				test_sign_in @user
				get :new
				response.should redirect_to(root_path)
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
				response.should have_selector("title", :content => "Clubs | New")
			end
			it "should have a back link" do
				response.should have_selector("a", :href => categories_path, :content => "Back")
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
			@cat = FactoryGirl.create(:category)
			@club = FactoryGirl.create(:organization, :category_id => @cat.id)
		end
		describe 'when not signed in' do
			it 'should not be success' do
				get :show, :id => @club
				response.should redirect_to sign_in_path
			end
		end
		describe "when signed in" do
			before do
				test_sign_in @user
				get :show, :id => @club
			end
			it "should be success" do
				response.should be_success
			end
			it 'should have a back link' do
				response.should have_selector('a', :href => category_path(@club.category_id), :content => 'Back')
			end
		end
	end

	describe "DELETE 'destroy'" do
		before do
			@user = FactoryGirl.create(:user)
			@cat = FactoryGirl.create(:category)
			@club = FactoryGirl.create(:organization, :category_id => @cat.id)
		end
		describe "as a non-signed-in user" do
			it "should deny access" do
				delete :destroy, :id => @club
				response.should redirect_to(root_path)
			end
		end
		describe "as a non-admin" do
			it "should deny access" do
				test_sign_in @user
				delete :destroy, :id => @club
				response.should redirect_to(root_path)
			end
		end
		describe "as an admin user" do
			before do             
				@user.toggle!(:admin)
				test_sign_in @user
			end
			it "should destroy the club" do
				lambda do
					delete :destroy, :id => @club
				end.should change(Organization, :count).by(-1)
			end
		end
	end
end
