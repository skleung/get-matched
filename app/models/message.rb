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

  attr_accessible :subject, :body, :sender, :recepient, :read

  validates_presence_of :subject, :body, :recepient
  validates :subject, length: { minimum: 3, maximum: 35 }
  validates :body, length: { minimum: 3, maximum: 1000 }
end
