require 'spec_helper'

describe "LayoutLinks" do
	
	before do
		FactoryGirl.create(:weather)
	end
	
	describe "GET /layout_links" do
		it "should have a Home page at '/'" do
			get '/'
			response.should have_selector('title', :content => "Home")
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
		before do
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
			response.should have_selector("a", :href => profile_user_path(@user),
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
	describe 'club behaviors' do
		before do
			@user = FactoryGirl.create(:user)
			@category = FactoryGirl.create(:category)
			@club = FactoryGirl.create(:organization, :category_id => @category.id)
			@other = FactoryGirl.create(:user, :email => 'cxycxy@cxy.com')
		end
		let (:sign_in_user){
			visit sign_in_path
			fill_in :email, :with => @user.email
			fill_in :password, :with => @user.password
			click_button 'Sign in'
		}
		let (:sign_in_other){
			visit sign_in_path
			fill_in :email, :with => @other.email
			fill_in :password, :with => @other.password
			click_button 'Sign in'
		}
		let (:other_visit_club){
			sign_in_other
			visit organization_path(@club)
		}
		let (:user_visit_wl){
			@club.add_admin! @user
			sign_in_user
			visit waitlists_organization_path(@club)
		}
		describe 'submit request to join a club' do
			before do
				other_visit_club
			end
			it 'should create a new org_relationship after applying' do
				expect {click_button 'Join club'}.to change(OrgRelationship, :count).by(1)
			end
			it 'should remove the org_relationship after cancelling request' do
				click_button 'Join club'
				expect {click_button 'Cancel request'}.to change(OrgRelationship, :count).by(-1)
			end
		end
		describe 'club accept a member' do
			before do
				other_visit_club
				click_button 'Join club'
				visit sign_out_path
				
				user_visit_wl
			end
			it 'should create a member_relationshp after accept' do
				expect{click_button 'Accept'}.to change(MemberRelationship, :count).by(1)
			end
			it 'should remove a org_relationshp after accept' do
				expect {click_button 'Accept'}.to change(OrgRelationship, :count).by(-1)
			end
			it 'should remove a org_relationshp after reject' do
				expect {click_button 'Reject'}.to change(OrgRelationship, :count).by(-1)
			end
		end
		describe 'user quit a club' do
			it 'should remove a member_relationship after quit' do
				@club.add_admin! @other

				other_visit_club
				expect {click_button 'Quit club'}.to change(MemberRelationship, :count).by(-1)
			end
		end
	end
end
