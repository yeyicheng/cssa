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
	
	belongs_to :club, class_name: "Organization"
	belong_to :member, class_name: "Organization"
	
	validates :club_id, :member_id, presence: true
end
