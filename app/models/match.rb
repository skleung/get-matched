# == Schema Information
#
# Table name: matches
#
#  id          :integer          not null, primary key
#  sender_id   :string(255)
#  receiver_id :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  accepted    :boolean
#  selling     :boolean
#

class Match < ActiveRecord::Base
	has_many :messages
end
