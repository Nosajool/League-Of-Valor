class Map < ActiveRecord::Base
	has_many :map_champions

	validates(:map_name,       presence: true)
	validates(:description,    presence: true)
end
