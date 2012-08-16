# == Schema Information
#
# Table name: weathers
#
#  id         :integer          not null, primary key
#  time       :string(255)
#  condition  :string(255)
#  temp_c     :decimal(, )
#  temp_f     :decimal(, )
#  icon_url   :string(255)
#  location   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Weather do
	before do
		@attr = {
			:time => '11:11',
			:condition => 'fair',
			:temp_c => 11.1,
			:temp_f => 22.2,
			:icon_url => '1.png',
			:location => 'College Park'
		}
	end
	it "should create a new instance given valid attributes" do
		Weather.create!(@attr)
	end
	
	it "should require time" do
		no_time = Weather.new(@attr.merge(:time => ""))
		no_time.should_not be_valid
	end
	
	it "should require temp_c" do
		no_temp_c = Weather.new(@attr.merge(:temp_c => ""))
		no_temp_c.should_not be_valid
	end
	
	it "should require temp_f" do
		no_temp_f = Weather.new(@attr.merge(:temp_f => ""))
		no_temp_f.should_not be_valid
	end
	
	it "should require icon_url" do
		no_icon_url = Weather.new(@attr.merge(:icon_url => ""))
		no_icon_url.should_not be_valid
	end
	
	it "should require location" do
		no_location = Weather.new(@attr.merge(:location => ""))
		no_location.should_not be_valid
	end

	it "should reject duplicate time" do
		Weather.create!(@attr)
		
		weather_with_duplicate_time = Weather.new(@attr)
		weather_with_duplicate_time.should_not be_valid
	end
end
