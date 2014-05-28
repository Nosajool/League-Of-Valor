class AddCatchRateToTableChampions < ActiveRecord::Migration
  def change
    add_column :table_champions, :catch_rate, :int
  end
end
