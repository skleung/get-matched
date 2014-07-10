# == Schema Information
#
# Table name: needs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  str_id     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Need < ActiveRecord::Base
	has_and_belongs_to_many :users
end
