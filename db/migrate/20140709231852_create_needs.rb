class CreateNeeds < ActiveRecord::Migration
  def change
    create_table :needs do |t|
      t.string :name
      t.string :str_id

      t.timestamps
    end
  end
end
