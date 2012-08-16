require 'spec_helper'

describe "Weathers" do
	before do
		FactoryGirl.create(:weather)
		@user = FactoryGirl.create(:user)
		visit sign_in_path
		fill_in :email, with: @user.email
		fill_in :password, with: @user.password
		click_button 'Sign in'
	end
	
	describe "GET /weathers" do
		it "works! (now write some real specs)" do
			get weathers_path
			response.status.should be(200)
		end
	end
end
