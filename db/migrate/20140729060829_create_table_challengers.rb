class CreateTableChallengers < ActiveRecord::Migration
  def change
    create_table :table_challengers do |t|
      t.string :name
      t.integer :table_champion_id

      t.timestamps
    end
  end
end
