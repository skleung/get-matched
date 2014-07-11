# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  username    :string(255)
#  locu_str_id :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  need        :string(255)
#  categories  :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
