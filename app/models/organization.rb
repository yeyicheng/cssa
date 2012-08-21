# == Schema Information
#
# Table name: organizations
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  description         :text
#  email               :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  category_id         :integer
#

class Organization < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "50x50>" }
	attr_accessible :description, :email, :name, :avatar, :category_id
	
	belongs_to :category
	
	has_many :member_relationships, foreign_key: 'club_id', dependent: :destroy, class_name: 'MemberRelationship'
	has_many :members, through: :member_relationships, source: :member
	has_many :reverse_org_relationships, foreign_key: 'club_id', dependent: :destroy, class_name: 'OrgRelationship'
	has_many :applicants, through: :reverse_org_relationships, source: :member
	
	has_many :club_admins, foreign_key: 'club_id', dependent: :destroy, class_name: 'ClubAdmin'
	has_many :admins, through: :club_admins, source: :member
	
	validates :name, presence: true, length: { maximum: 30, minimum: 3 }, uniqueness: true
	validates :email, presence: true, uniqueness: true
	validates :description, presence: true, length: { maximum: 300, minimum: 5 }
	
	def has_member?(member)
		member_relationships.find_by_member_id(member.id)
	end
	
	def waitlist? member
		reverse_org_relationships.find_by_member_id(member.id)
	end
	
	def accept! member
		org_rel = waitlist? member
		if org_rel
			member_relationships.create!(member_id: member.id)
			org_rel.destroy
		end
	end
	
	def reject! member
		org_rel = waitlist? member
		org_rel.destroy unless !org_rel
	end
	
	def remove!(member)
		mem_rel = has_member? member
		mem_rel.destroy unless !mem_rel
	end
	
	def has_admin? user
		return nil if !has_member? user
		club_admins.find_by_member_id(user.id)
	end
	
	def add_admin! user
		if !has_member? user
			user.join! self
			accept! user
		end
		club_admins.create!(member_id: user.id) unless self.has_admin? user
	end
	
	def remove_admin! user
		admin = has_admin? user
		admin.destroy unless !admin
	end
end
