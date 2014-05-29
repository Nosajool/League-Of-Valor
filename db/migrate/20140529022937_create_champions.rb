class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.integer :table_champion_id
      t.integer :experience
      t.integer :user_id
      t.integer :position

      t.timestamps
    end
    add_index :champions, [:user_id, :created_at]
  end
end
