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


  def all_messages
    Message.where('(sender_id = :sender_id AND receiver_id = :receiver_id) OR (sender_id = :receiver_id AND receiver_id = :sender_id)', sender_id: sender_id, receiver_id: receiver_id)
  end

  def unread_messages_for_user(locu_id)
    if sender_id == locu_id
      Message.where('(sender_id = :sender_id AND receiver_id = :receiver_id)', sender_id: receiver_id, receiver_id: locu_id).where(read: nil)
    else
      Message.where('(sender_id = :sender_id AND receiver_id = :receiver_id)', sender_id: sender_id, receiver_id: locu_id).where(read: nil)
    end
  end

  class << self
    def total_unread_messages(swagforlife)
      if swagforlife
        Message.where('receiver_id = :id', id: swagforlife).where(read: nil).count
      else
        0
      end
    end
  end
end
