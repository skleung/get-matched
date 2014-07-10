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
#  match_id    :integer
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
