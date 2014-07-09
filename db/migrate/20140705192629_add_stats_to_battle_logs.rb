class AddStatsToBattleLogs < ActiveRecord::Migration
  def change
  	add_column :battle_logs, :description, :text
    add_column :battle_logs, :champ1, :float
    add_column :battle_logs, :champ2, :float
    add_column :battle_logs, :champ3, :float
    add_column :battle_logs, :champ4, :float
    add_column :battle_logs, :champ5, :float
    add_column :battle_logs, :ochamp1, :float
    add_column :battle_logs, :ochamp2, :float
    add_column :battle_logs, :ochamp3, :float
    add_column :battle_logs, :ochamp4, :float
    add_column :battle_logs, :ochamp5, :float    
    add_column :battle_logs, :extra, :float
  end
end
