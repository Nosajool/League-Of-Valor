class AddStatsToTableChampions < ActiveRecord::Migration
  def change
    add_column :table_champions, :health, :int
    add_column :table_champions, :attack_damage, :int
    add_column :table_champions, :ability_power, :int
    add_column :table_champions, :armor, :int
    add_column :table_champions, :magic_resist, :int
  end
end
