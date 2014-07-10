class ChangeFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :matches, :sender_id, :string
    change_column :matches, :receiver_id, :string
  end
end
