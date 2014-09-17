class AddIndexToBuffs < ActiveRecord::Migration
  def change
  	add_index :buffs, :user_id
  end
end
