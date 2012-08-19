class Category < ActiveRecord::Base
	attr_accessible :name, :description, :avatar, :club_id
	has_attached_file :avatar, :styles => { :large => '150x150>', :medium => "100x100>", :thumb => "50x50>" }
	
	has_many :clubs, class_name: "Organizations"
end
