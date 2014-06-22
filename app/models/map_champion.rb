class MapChampion < ActiveRecord::Base
	belongs_to :map

	validates(:key,      presence: true)
	# champ key
	validates(:probability, presence: true,
							inclusion: { in: 0..100 } )
end
