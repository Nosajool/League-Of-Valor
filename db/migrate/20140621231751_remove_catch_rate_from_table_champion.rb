class RemoveCatchRateFromTableChampion < ActiveRecord::Migration
  def change
    remove_column :table_champions, :catch_rate, :int
    remove_column :table_champions, :role, :string
    rename_column :table_champions, :health, :hp
    rename_column :table_champions, :champ_name, :name
    rename_column :table_champions, :range, :attack_range
  end
end
