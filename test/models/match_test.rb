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

require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
