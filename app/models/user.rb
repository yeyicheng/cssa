# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	devise :database_authenticatable, :oauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
         
	has_many :identities, dependent: :destroy
	has_many :microposts, dependent: :destroy
	
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :following, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
	
	has_many :org_relationships, foreign_key: "member_id", dependent: :destroy, class_name: "OrgRelationships"
	has_many :clubs, through: :org_relationships, source: :member
	
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
	
	def feed
		Micropost.where("user_id = ?", id)
	end
	
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
		
	def following?(followed)
		relationships.find_by_followed_id(followed)
	end
	
	def follow!(followed)
		relationships.create!(followed_id: followed.id)
	end
	
	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
	
	def joined?(club)
		org_relationships.find_by_club_id(club.id)
	end
	
	def join!(club)
		org_relationships.create!(club_id: club.id)
	end
	
	def quit!(club)
		org_relationships.find_by_club_id(club.id).destroy
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
