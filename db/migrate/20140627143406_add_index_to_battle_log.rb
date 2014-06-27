class AddIndexToBattleLog < ActiveRecord::Migration
  def change
  	add_index :battle_logs, :battle_id
  end
end
