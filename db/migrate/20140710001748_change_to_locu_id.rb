class ChangeToLocuId < ActiveRecord::Migration
  def change
    change_column :messages, :sender_id, :string
    change_column :messages, :receiver_id, :string
  end
end
