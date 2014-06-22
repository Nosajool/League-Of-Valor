class AddIndexToTableChhampionsKey < ActiveRecord::Migration
  def change
  	add_index :table_champions, :key, unique: true
  end
end
