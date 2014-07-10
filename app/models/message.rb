# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  sender_id   :string(255)
#  receiver_id :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  read        :boolean
#

class Message < ActiveRecord::Base
	belongs_to :match
  #validates_presence_of :body, :recepient
  #validates length: { minimum: 3, maximum: 35 }
  #validates :body, length: { minimum: 3, maximum: 1000 }



  #validates_presence_of :subject, :body, :recepient
  #validates :subject, length: { minimum: 3, maximum: 35 }
  #validates :body, length: { minimum: 3, maximum: 1000 }
end
