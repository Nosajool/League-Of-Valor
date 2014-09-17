class TableChallenger < ActiveRecord::Base
	belongs_to :table_champion
	has_many :challengers
end
