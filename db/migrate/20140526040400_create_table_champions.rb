class CreateTableChampions < ActiveRecord::Migration
  def change
    create_table :table_champions do |t|
      t.string :champ_name

      t.timestamps
    end
  end
end
