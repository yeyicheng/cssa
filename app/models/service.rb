# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Service < ActiveRecord::Base
	belongs_to :user
	attr_accessible :provider, :uid
end
