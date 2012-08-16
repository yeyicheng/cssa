require 'spec_helper'

describe "Users" do
	describe "Following/ followers" do
		before do
			@follower = FactoryGirl.create(:user)
			@followed = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
			# @relationship = @follower.relationships.build(:followed_id => @followed.id)
			
			visit sign_in_path
			fill_in :email, :with => @follower.email
			fill_in :password, :with => @follower.password
			
			click_button 'Sign in'
		end
	
		it "should follow the followed" do
			# Run the generator again with the --webrat flag if you want to use webrat methods/matchers	
			visit user_path(@followed)
			click_button 'Follow'
			@follower.relationships.find_by_followed_id(@followed).should_not be_nil
		end
		
		it "should unfollow the followed" do
			@relationship = @follower.relationships.build(:followed_id => @followed.id)
			@relationship.save!
			visit user_path(@followed)
			click_button 'Unfollow'
			@follower.relationships.find_by_followed_id(@followed).should be_nil
		end
	end
end
