class AddChampionIdToBattleLogs < ActiveRecord::Migration
  def change
    add_column :battle_logs, :champion_id, :int
  end
end
