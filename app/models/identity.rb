# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  provider   :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Identity < ActiveRecord::Base
	belongs_to :user
	attr_accessible :provider, :uid
	
	def self.find_with_omniauth(auth)
		find_by_provider_and_uid(auth['provider'], auth['uid'])
	end
	
	def self.create_with_omniauth(auth)
		create(uid: auth['uid'], provider: auth['provider'])
	end
end
