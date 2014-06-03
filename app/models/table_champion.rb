class TableChampion < ActiveRecord::Base
	has_many :champions
	validates(:champ_name, 				 presence: true)

	validates(:health,                   presence: true,
					                     inclusion: { in: 0..255 } )

	validates(:attack_damage, 			 presence: true,
							             inclusion: { in: 0..255 } )

	validates(:ability_power, 			 presence: true,
							             inclusion: { in: 0..255 } )

	validates(:armor, 					 presence: true,
							             inclusion: { in: 0..255 } )

	validates(:magic_resist, 			 presence: true,
							             inclusion: { in: 0..255 } )

	validates(:role, 					 presence: true,
							             inclusion: { in: %w(Marksman Mage Support Assasin Fighter Tank),
							             			  message: "%{value} is not a valid role" } )

	validates(:catch_rate, 				 presence: true )

	validates(:range,                    presence: true,
										 inclusion: { in: 1..10 } )
end
