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

require 'spec_helper'

describe Organizations do
  pending "add some examples to (or delete) #{__FILE__}"
end