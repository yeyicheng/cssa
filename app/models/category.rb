# == Schema Information
#
# Table name: categories
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  description         :text
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Category < ActiveRecord::Base
	attr_accessible :name, :description, :avatar, :club_id
	has_attached_file :avatar, :styles => { :large => '150x150>', :medium => "100x100>", :thumb => "50x50>" }
	
	has_many :clubs, class_name: "Organization"
end
