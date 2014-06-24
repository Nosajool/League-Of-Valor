class CreateSkins < ActiveRecord::Migration
  def change
    create_table :skins do |t|
      t.integer :table_champion_id
      t.integer :num
      t.string :name

      t.timestamps
    end
  end
end
