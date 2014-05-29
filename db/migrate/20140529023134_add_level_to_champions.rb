class AddLevelToChampions < ActiveRecord::Migration
  def change
    add_column :champions, :level, :int
  end
end
