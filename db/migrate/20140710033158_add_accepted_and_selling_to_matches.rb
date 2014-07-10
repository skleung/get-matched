class AddAcceptedAndSellingToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :accepted, :boolean
    add_column :matches, :selling, :boolean
  end
end
