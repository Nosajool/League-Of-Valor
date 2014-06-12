class AddSkinsToChampions < ActiveRecord::Migration
  def change
    add_column :champions, :skin, :int
    add_column :champions, :active_skin, :int
  end
end
