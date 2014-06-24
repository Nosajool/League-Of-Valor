class CreateSkins < ActiveRecord::Migration
  def change
    create_table :skins do |t|
      t.int :table_champion_id
      t.int :num
      t.string :name

      t.timestamps
    end
  end
end
