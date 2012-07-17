class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  email_regex = /^[\w+\-._]+@[a-z\d\-._]+\.[a-z]+$/i
  
  validates :name, :presence => true, 
				   :length => { :maximum => 30, :minimum => 5 }
				   
  validates :email, :presence => true, 
					:format => { :with => email_regex },
					:uniqueness => { :case_sensitive => false }
  
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

