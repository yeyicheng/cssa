
class User < ActiveRecord::Base
	has_many :microposts, :dependent => :destroy
	
	attr_accessor :password
	
	attr_accessible :email, :name, :password, :password_confirmation

	email_regex = /^[\w+\-._]+@[a-z\d\-._]+\.[a-z]+$/i

	validates :name, :presence => true, 
					 :length => { :maximum => 30, :minimum => 5 }
				   
	validates :email, :presence => true, 
					  :format => { :with => email_regex },
					  :uniqueness => { :case_sensitive => false }

	validates :password, :confirmation => true,
						 :length => { :within => 6..40 }
						 
	before_save :encrypt_password
	
	# Return true if the user's password matches the submitted password.
	def password_matched? (submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.password_matched?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil	
	end
		
	private
	
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(pwd)
			secure_hash("#{salt}--#{pwd}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

