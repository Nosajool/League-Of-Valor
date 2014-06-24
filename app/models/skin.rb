class Skin < ActiveRecord::Base
	belongs_to: :table_champion
	validates(:table_champion_id, presence: true)
	validates(:num,               presence: true,
								  inclusion: { in: 0..9 } )
	validates(:name,              presence: true)
end
