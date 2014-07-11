class FixNeeds < ActiveRecord::Migration
  def change
    rename_column :users, :need, :needs
  end
end
