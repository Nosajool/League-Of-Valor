class AddOtherChampionIdToBattleLogs < ActiveRecord::Migration
  def change
    add_column :battle_logs, :other_champion_id, :int
  end
end
