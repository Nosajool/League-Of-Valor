class TableChampion < ActiveRecord::Base
	has_many :champions

	validates(:name, 					 presence: true)
	validates(:riot_champ_id,            presence: true)
	validates(:key,                      presence: true)
	validates(:title,                    presence: true)
	validates(:lore,                     presence: true)

	validates(:hp,             		     presence: true)
	validates(:hp_per_level,             presence: true)

	validates(:attack_damage, 			 presence: true)
	validates(:attack_damage_per_level,  presence: true)

	validates(:ability_power, 			 presence: true)
	validates(:ability_power_per_level,  prensence: true)

	validates(:armor, 					 presence: true)
	validates(:armor_per_level,          presence: true)

	validates(:magic_resist, 			 presence: true)
	validates(:magic_resist_per_level,   presence: true)

	validates(:attack_range,             presence: true)
	validates(:movespeed,                presenece: true)

	validates(:f_role, 					 presence: true,
										 inclusion: { in: %w(Marksman Mage Support Assasin Fighter Tank),
							             			  message: "%{value} is not a valid role" } )

	# validates(:s_role, presence: true)


end
