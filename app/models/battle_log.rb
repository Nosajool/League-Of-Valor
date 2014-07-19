class BattleLog < ActiveRecord::Base
	belongs_to :battle

	validates :battle_id, presence: true
end
