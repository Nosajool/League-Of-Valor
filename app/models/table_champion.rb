class TableChampion < ActiveRecord::Base
	validates(:champ_name, presence: true)
	validates(:attack_damage, presence: true)
end
