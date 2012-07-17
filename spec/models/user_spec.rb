require 'spec_helper'

describe User do
	
	before(:each) do
		@attr = { :name => "Example User", :email => "user@example.com" }
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
	
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

