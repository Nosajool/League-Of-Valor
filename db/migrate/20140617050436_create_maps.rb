class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :map_name
      t.text :description

      t.timestamps
    end
  end
end
