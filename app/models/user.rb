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

class User < ActiveRecord::Base
	has_and_belongs_to_many :matches

  class << self
    def get_name(locu_str_id)
      if User.where(locu_str_id: locu_str_id).empty?
        #return locu_str_id
        return searchForBusiness(locu_str_id)['name']
      else
        return User.where(locu_str_id: locu_str_id).first.username
      end
    end

    def get_categories(locu_str_id, categories)
      user = User.where(locu_str_id: locu_str_id).first
      if user and user.categories
        return user.categories
      elsif categories
        categories.map! {|c| c['name']}
        return categories.join(', ') 
      end
      return ''
    end
    def get_needs(locu_str_id)
      user = User.where(locu_str_id: locu_str_id).first
      return user.needs
    end
  end

end
