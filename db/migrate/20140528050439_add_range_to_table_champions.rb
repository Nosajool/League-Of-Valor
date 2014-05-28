class AddRangeToTableChampions < ActiveRecord::Migration
  def change
    add_column :table_champions, :range, :int
  end
end
