class AddDuserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :duser, :string
  end
end
