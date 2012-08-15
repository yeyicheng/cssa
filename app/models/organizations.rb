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
	
	has_many :reverse_orgrelationships, foreign_key: 'club_id', dependent: :destroy 
	has_many :members, through: :reverse_orgrelationships, source: :club
	
	email_regex = /^[\w+\-._]+@[a-z\d\-._]+\.[a-z]+$/i
	url_regex = /\.[jpg|png|gif]$/i
	
	validates :name, presence: true, length: { maximum: 30, minimum: 3 }, uniqueness: true
	validates :email, presence: true, format: { with: email_regex }, uniqueness: true
	validates :descrption, presence: true, length: { maximum: 300, minimum: 5 }
	validates :logo_url, presence: true, format: { with: url_regex }
end
