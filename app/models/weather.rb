# == Schema Information
#
# Table name: weathers
#
#  id         :integer          not null, primary key
#  condition  :string(255)
#  temp_c     :decimal(, )
#  temp_f     :decimal(, )
#  icon_url   :string(255)
#  location   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Weather < ActiveRecord::Base
	default_scope :order => 'weathers.created_at DESC'
	attr_accessible :condition, :icon_url, :temp_c, :temp_f, :location, :created_at

	validates :condition, :icon_url, :temp_c, :temp_f, :location, :presence => true
end
