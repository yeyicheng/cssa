# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Relationship do
	before do
		@follower = FactoryGirl.create(:user)
		@followed = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
		@relationship = @follower.relationships.build(:followed_id => @followed.id)
	end
	it "should create a new instance given valid attributes" do
		@relationship.save!
	end
	
	describe "follow methods" do
		before do
			@relationship.save
		end
		it "should have a follower attribute" do
			@relationship.should respond_to(:follower)
		end
		it "should have the right follower" do
			@relationship.follower.should == @follower
		end
		it "should have a followed attribute" do
			@relationship.should respond_to(:followed)
		end
		it "should have the right followed user" do
			@relationship.followed.should == @followed
		end
	end
	
	describe "validations" do
		it "should require a follower_id" do
			@relationship.follower_id = nil
			@relationship.should_not be_valid
		end
		it "should require a followed_id" do
			@relationship.followed_id = nil
			@relationship.should_not be_valid
		end
	end
	
	describe "relationships" do
		before do
			@attr = { 
				:name => "Example User", 
				:email => "user@example.com", 
				:password => "foobar",
				:password_confirmation => "foobar"
			}
			@user = User.create!(@attr.merge(:name => 'aa@aa.com'))
		end
		it "should have a relationships method" do
			@user.should respond_to(:relationships)
		end
		it "should have a following method" do
			@user.should respond_to(:following)
		end
	end
end
