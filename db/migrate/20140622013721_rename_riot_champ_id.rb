class RenameRiotChampId < ActiveRecord::Migration
  def change
     rename_column :table_champions, :riot_champ_id, :riot_id
  end
end
