# == Schema Information
#
# Table name: weathers
#
#  id         :integer          not null, primary key
#  condition  :string(255)
#  temp_c     :decimal(4, 1)
#  temp_f     :decimal(4, 1)
#  icon_url   :string(255)
#  location   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Weather do
  pending "add some examples to (or delete) #{__FILE__}"
end
