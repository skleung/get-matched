class AddMatchIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :match_id, :integer
  end
end
