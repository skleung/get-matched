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

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
