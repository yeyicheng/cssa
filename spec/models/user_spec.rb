# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)
#  salt                   :string(255)
#  admin                  :boolean          default(FALSE)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

require 'spec_helper'

describe User do
	
	before(:each) do
		@attr = { 
			:name => "Example User", 
			:email => "user@example.com", 
			:password => "foobar",
			:password_confirmation => "foobar"
		}
	end
	
	it "should create a new instance given valid attributes" do
		User.create!(@attr)
	end
	
	it "should require a name" do
		no_name_user = User.new(@attr.merge(:name => ""))
		no_name_user.should_not be_valid
	end
	
	it "should require a email" do
		no_name_user = User.new(@attr.merge(:email => ""))
		no_name_user.should_not be_valid
	end
	
	it "should reject names that are too long or too short" do
		long_name = "a" * 51
		long_name_user = User.new(@attr.merge(:name => long_name))
		long_name_user.should_not be_valid
		
		short_name = "a" * 4
		short_name_user = User.new(@attr.merge(:name => short_name))
		short_name_user.should_not be_valid
	end
	
	it "should accept valid email addresses" do
		addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp sz_yyc@hotmail.com]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
	end
	
	it "should reject invalid email addresses" do
		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address))
			invalid_email_user.should_not be_valid
		end
	end
	
	it "should reject duplicate email addresses" do
		# Put a user with given email address into the database.
		User.create!(@attr)
		
		user_with_duplicate_email = User.new(@attr.merge(:name => ""))
		user_with_duplicate_email.should_not be_valid
		
		user_with_duplicate_email = User.new(@attr.merge(:email => @attr[:email].upcase))
		user_with_duplicate_email.should_not be_valid
	end
	
	describe "password validations" do
		it "should require a password" do
			User.new(@attr.merge(:password => "", :password_confirmation => "")).
			should_not be_valid
		end
		
		it "should require a matching password confirmation" do
			User.new(@attr.merge(:password_confirmation => "invalid")).
			should_not be_valid
		end
		
		it "should reject short passwords" do
			short = "a" * 5
			hash = @attr.merge(:password => short, :password_confirmation => short)
			User.new(hash).should_not be_valid
		end
		
		it "should reject long passwords" do
			long = "a" * 41
			hash = @attr.merge(:password => long, :password_confirmation => long)
			User.new(hash).should_not be_valid
		end
	end
	
	describe "password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end
		
		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end
		
		it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
		end
	end
	
	describe "password_matched? method" do
		before(:each) do
			@user = User.create!(@attr)
		end
		
		it "should be true if the passwords match" do
			@user.password_matched?(@attr[:password]).should be_true
		end
		
		it "should be false if the passwords don't match" do
			@user.password_matched?("invalid").should be_false
		end
	end
	
	describe "authenticate method" do
		it "should return nil on email/password mismatch" do
			wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
			wrong_password_user.should be_nil
		end
		it "should return nil for an email address with no user" do
			nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
			nonexistent_user.should be_nil
		end
		it "should return the user on email/password match" do
			matching_user = User.authenticate(@attr[:email], @attr[:password])
			matching_user.should == @user
		end
	end
	
	describe "admin attribute" do
		before(:each) do
			@user = User.create!(@attr)
		end
		it "should respond to admin" do
			@user.should respond_to(:admin)
		end
		it "should not be an admin by default" do
			@user.should_not be_admin
		end
		it "should be convertible to an admin" do
			@user.toggle!(:admin)
			@user.should be_admin
		end
	end
	
	describe "micropost associations" do
		before(:each) do
			@user = User.create(@attr)
			@mp1 = FactoryGirl.create(:micropost, :user => @user, :created_at => 1.day.ago)
			@mp2 = FactoryGirl.create(:micropost, :user => @user, :created_at => 1.hour.ago)
		end
		it "should have a microposts attribute" do
			@user.should respond_to(:microposts)
		end
		it "should have the right microposts in the right order" do
			@user.microposts.should == [@mp2, @mp1]
		end

		describe "status feed" do
			it "should have a feed" do
				@user.should respond_to(:feed)
			end
			it "should include the user's microposts" do
				@user.feed.include?(@mp1).should be_true
				@user.feed.include?(@mp2).should be_true
			end
			it "should not include a different user's microposts" do
				mp3 = FactoryGirl.create(:micropost, :user => FactoryGirl.create(:user, :email => FactoryGirl.generate(:email)))
				@user.feed.include?(mp3).should be_false
			end
		end
		
		describe "status feed" do
			it "should have a feed" do
				@user.should respond_to(:feed)
			end
			it "should include the user's microposts" do
				@user.feed.should include(@mp1)
				@user.feed.should include(@mp2)
			end
			it "should not include a different user's microposts" do
				mp3 = FactoryGirl.create(:micropost,
					:user => FactoryGirl.create(:user, :email => FactoryGirl.generate(:email)))
				@user.feed.should_not include(mp3)
			end
			it "should include the microposts of followed users" do
				followed = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
				mp3 = FactoryGirl.create(:micropost, :user => followed)
				@user.follow!(followed)
				@user.feed.should include(mp3)
			end
		end
	end
	
	describe "relationships" do
		before do
			@user = User.create!(@attr)
			@followed = FactoryGirl.create(:user)
		end
		it "should have a relationships method" do
			@user.should respond_to(:relationships)
		end
		it "should have a following method" do
			@user.should respond_to(:following)
		end
		it "should have a following? method" do
			@user.should respond_to(:following?)
		end
		it "should have a follow! method" do
			@user.should respond_to(:follow!)
		end
		it "should follow another user" do
			@user.follow!(@followed)
			@user.should be_following(@followed)
		end
		it "should include the followed user in the following array" do
			@user.follow!(@followed)
			@user.following.should include(@followed)
		end
		it "should have an unfollow! method" do
			@followed.should respond_to(:unfollow!)
		end
		it "should unfollow a user" do
			@user.follow!(@followed)
			@user.unfollow!(@followed)
			@user.should_not be_following(@followed)
		end
		it "should destroy all associated relationships" do
			@user.destroy
			@user.relationships.should be_empty
		end
	end
end                                             
