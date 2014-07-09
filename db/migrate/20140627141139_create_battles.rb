class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :user_id
      t.integer :opp_id
      t.integer :champ1
      t.integer :champ2
      t.integer :champ3
      t.integer :champ4
      t.integer :champ4
      t.integer :champ5
      t.integer :champ6
      t.integer :champ7
      t.integer :champ8
      t.integer :champ9
      t.integer :champ10

      t.timestamps
    end
  end
end
