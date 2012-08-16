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

require 'spec_helper'

describe Identity do
  pending "add some examples to (or delete) #{__FILE__}"
end
