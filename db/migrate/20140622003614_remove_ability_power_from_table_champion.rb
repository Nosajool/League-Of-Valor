class RemoveAbilityPowerFromTableChampion < ActiveRecord::Migration
  def change
    remove_column :table_champions, :ability_power, :int
    remove_column :table_champions, :ability_power_per_level, :float
  end
end
