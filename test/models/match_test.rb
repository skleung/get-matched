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

require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
