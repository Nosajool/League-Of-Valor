class AddRoleToTableChampions < ActiveRecord::Migration
  def change
    add_column :table_champions, :role, :string
  end
end
