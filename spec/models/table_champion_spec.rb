require 'spec_helper'

describe TableChampion do
	before do
		@table_champion = TableChampion.new( champ_name: "Warwick",
											 health: 40,
											 attack_damage: 85,
											 ability_power: 75,
											 armor: 50,
											 magic_resist: 65,
											 role: "Marksman",
										 	 catch_rate: 1500 )
	end

	subject { @table_champion }

	it { should respond_to(:champ_name) }
	it { should respond_to(:health) }
	it { should respond_to(:attack_damage) }
	it { should respond_to(:ability_power) }
	it { should respond_to(:armor) }
	it { should respond_to(:magic_resist) }
	it { should respond_to(:role) }
	it { should respond_to(:catch_rate) }
end
