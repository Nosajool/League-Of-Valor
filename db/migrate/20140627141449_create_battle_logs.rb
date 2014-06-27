class CreateBattleLogs < ActiveRecord::Migration
  def change
    create_table :battle_logs do |t|
      t.integer :battle_id
      t.text :event

      t.timestamps
    end
  end
end
