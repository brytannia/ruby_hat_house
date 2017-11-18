# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Member < ApplicationRecord
end
