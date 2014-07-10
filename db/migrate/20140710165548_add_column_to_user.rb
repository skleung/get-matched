class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :need, :string
    add_column :users, :categories, :string
  end
end
