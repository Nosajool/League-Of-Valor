class AddEventNumToBattleLogs < ActiveRecord::Migration
  def change
    add_column :battle_logs, :event_num, :int
  end
end
