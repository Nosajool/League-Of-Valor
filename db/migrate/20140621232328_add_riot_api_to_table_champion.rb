class AddRiotApiToTableChampion < ActiveRecord::Migration
  def change
    add_column :table_champions, :riot_champ_id, :int
    add_column :table_champions, :key, :string
    add_column :table_champions, :title, :text
    add_column :table_champions, :f_role, :string
    add_column :table_champions, :s_role, :string
    add_column :table_champions, :lore, :text
    add_column :table_champions, :hp_per_level, :int
    add_column :table_champions, :attack_damage_per_level, :float
    add_column :table_champions, :ability_power_per_level, :float
    add_column :table_champions, :armor_per_level, :float
    add_column :table_champions, :magic_resist_per_level, :float
    add_column :table_champions, :movespeed, :int
  end
end
