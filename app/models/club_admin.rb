# == Schema Information
#
# Table name: club_admins
#
#  id         :integer          not null, primary key
#  club_id    :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClubAdmin < ActiveRecord::Base
	attr_accessible :member_id
  
	belongs_to :club, class_name: 'Organization'
 	belongs_to :member, class_name: 'User'
 	
	validates :club_id, :member_id, presence: true
end
