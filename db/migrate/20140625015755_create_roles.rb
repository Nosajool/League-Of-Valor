class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
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
