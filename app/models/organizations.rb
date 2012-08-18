# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  email       :string(255)
#  logo_url    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Organizations < ActiveRecord::Base
	attr_accessible :description, :email, :logo_url, :name
	
	has_many :member_relationships, foreign_key: 'club_id', dependent: :destroy, class_name: 'MemberRelationship'
	has_many :members, through: :member_relationships, source: :member
	has_many :reverse_org_relationships, foreign_key: 'club_id', dependent: :destroy, class_name: 'OrgRelationships'
	has_many :applicants, through: :reverse_org_relationships, source: :member
	
	email_regex = /^[\w+\-._]+@[a-z\d\-._]+\.[a-z]+$/i
	url_regex = /\.(png|jpg|gif)$/
	
	validates :name, presence: true, length: { maximum: 30, minimum: 3 }, uniqueness: true
	validates :email, presence: true, format: { with: email_regex }, uniqueness: true
	validates :description, presence: true, length: { maximum: 300, minimum: 5 }
	validates :logo_url, presence: true, format: { with: url_regex }

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
		if mem_rel
			mem_rel.destroy
		end
	end
end
