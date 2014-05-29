class Champion < ActiveRecord::Base
	validates(:experience, 				 presence: true)

	validates(:level,                    presence: true)

	validates(:position,                 presence: true,
										 inclusion: { in: 0..5 } )

	validates(:skin,                     presence: true,
										 inclusion: { in: 1000000000..1111111111 } )
	
	validates(:active_skin,              presence: true,
										 inclusion: { in: 0..9 } )
end
