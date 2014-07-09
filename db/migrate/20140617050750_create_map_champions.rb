class CreateMapChampions < ActiveRecord::Migration
  def change
    create_table :map_champions do |t|
      t.integer :map_id
      t.integer :champ_id
      t.integer :probability

      t.timestamps
    end
    add_index :map_champions, [:map_id]
  end
end
