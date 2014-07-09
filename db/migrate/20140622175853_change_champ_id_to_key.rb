class ChangeChampIdToKey < ActiveRecord::Migration
  def change
    add_column :map_champions, :key, :string
    remove_column :map_champions, :champ_id, :int
  end
end
