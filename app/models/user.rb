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

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	# devise :database_authenticatable, :registerable,
	# :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    # attr_accessible :remember_me
	# devise :database_authenticatable, :omniauthable, :registerable,
	# :recoverable, :rememberable, :trackable, :validatable,
	# :confirmable, :lockable
    
	has_many :services, dependent: :destroy
	has_many :microposts, dependent: :destroy
	
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :following, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	
	has_many :org_relationships, foreign_key: "member_id", dependent: :destroy, class_name: "OrgRelationships"
	has_many :applied_clubs, through: :org_relationships, source: :club
	has_many :reverse_member_relationships, foreign_key: "member_id", dependent: :destroy, class_name: "MemberRelationship"
	has_many :clubs, through: :reverse_member_relationships, source: :club
	
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
	
	def self.create_with_omniauth(info)
		create(name: info['name'], email: info['email'])
	end
	
	# Return true if the user's password matches the submitted password.
	def password_matched? (submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.find_from_auth_hash(uid, auth_hash)
		User.find(auth_hash[uid])
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
		
	def following?(followed)
		relationships.find_by_followed_id(followed)
	end
	
	def follow!(followed)
		relationships.create!(followed_id: followed.id)
	end
	
	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
	
	def applied? club
		org_relationships.find_by_club_id(club.id)
	end
	
	def joined? club
		reverse_member_relationships.find_by_club_id(club.id)
	end
	
	def join! club
		if !joined? club and !applied? club
			org_relationships.create!(club_id: club.id)
		end
	end
	
	def cancel! club
		org_rel =  applied? club
		org_rel.destroy unless !org_rel
	end
	
	def quit! club
		mem_rel = joined? club
		
		if mem_rel
			mem_rel.destroy
		end
	end
	
	def feed
		Micropost.from_users_followed_by(self)
	end
	
	private
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def encrypt_password
			return if password.nil?
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
