# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  sender_id   :integer
#  receiver_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Message < ActiveRecord::Base
	belongs_to :match
end
