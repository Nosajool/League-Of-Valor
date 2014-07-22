class CreateBuffs < ActiveRecord::Migration
  def change
    create_table :buffs do |t|
      t.text :name
      t.text :title
      t.text :description
      t.integer :user_id
      t.float :hp_base
      t.float :hp_per
      t.float :ad_base
      t.float :ad_per
      t.float :ap_base
      t.float :ap_per
      t.float :ar_base
      t.float :ar_per
      t.float :mr_base
      t.float :mr_per
      t.float :ms_base
      t.float :ms_per

      t.timestamps
    end
  end
end
