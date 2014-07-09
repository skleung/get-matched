# == Schema Information
#
# Table name: matches
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Match < ActiveRecord::Base
	has_many :messages
end
