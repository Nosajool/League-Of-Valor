class CreateChallengers < ActiveRecord::Migration
  def change
    create_table :challengers do |t|
      t.integer :user_id
      t.integer :table_challenger_id

      t.timestamps
    end
  end
end
