class AddIconToUsers < ActiveRecord::Migration
  def change
    add_column :users, :icon, :int
  end
end
