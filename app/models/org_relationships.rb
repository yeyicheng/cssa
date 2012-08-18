# == Schema Information
#
# Table name: org_relationships
#
#  id         :integer          not null, primary key
#  club_id    :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrgRelationships < ActiveRecord::Base
	attr_accessible :club_id
	
	belongs_to :club, class_name: "Organizations"
	belongs_to :member, class_name: "User"
	
	validates :club_id, :member_id, presence: true
end
