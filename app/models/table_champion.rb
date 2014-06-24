class TableChampion < ActiveRecord::Base
	has_many :champions
	has_many :skins

	validates(:name, 					 presence: true)
	validates(:riot_id,       		     presence: true)
	validates(:key,                      presence: true)
	validates(:title,                    presence: true)
	validates(:lore,                     presence: true)

	validates(:hp,             		     presence: true,
										 inclusion: { in: 0..500 } )
	validates(:hp_per_level,             presence: true)

	validates(:attack_damage, 			 presence: true,
										 inclusion: { in: 0..60} )
	validates(:attack_damage_per_level,  presence: true)

	validates(:armor, 					 presence: true,
										 inclusion: { in: 0..30 } )
	validates(:armor_per_level,          presence: true)

	validates(:magic_resist, 			 presence: true,
										 inclusion: { in: 0..30 } )
	validates(:magic_resist_per_level,   presence: true)

	validates(:attack_range,             presence: true,
									     inclusion: { in: 0..700 } )
	validates(:movespeed,                presence: true,
									     inclusion: { in: 0..360 } )

	validates(:f_role, 					 presence: true,
										 inclusion: { in: %w(Marksman Mage Support Assassin Fighter Tank None),
							             			  message: "%{value} is not a valid role" } )

	# validates(:s_role, presence: true)


end
