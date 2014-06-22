require 'spec_helper'

describe TableChampion do
	before do
		@table_champion = TableChampion.new( name: "Miss Fortune",
											 hp: 400,
											 attack_damage: 85,
											 armor: 50,
											 magic_resist: 65,
											 attack_range: 550,
											 riot_id: 4,
											 key: "MissFortune",
											 title: "the Odd One",
											 f_role: "Assassin",
											 s_role: "Tank",
											 lore: "One day, Miss Fortune was doing something when hi",
											 hp_per_level: 34,
											 attack_damage_per_level: 3.2,
											 armor_per_level: 2.2,
											 magic_resist_per_level: 1.4,
											 movespeed: 330 )
	end

	subject { @table_champion }

	it { should respond_to(:id) }
	it { should respond_to(:name) }
	it { should respond_to(:hp) }
	it { should respond_to(:attack_damage) }
	it { should respond_to(:armor) }
	it { should respond_to(:magic_resist) }
	it { should respond_to(:attack_range) }
	it { should respond_to(:riot_id) }
	it { should respond_to(:key) }
	it { should respond_to(:title) }
	it { should respond_to(:f_role) }
	it { should respond_to(:s_role) }
	it { should respond_to(:lore) }
	it { should respond_to(:hp_per_level) }
	it { should respond_to(:attack_damage_per_level) }
	it { should respond_to(:armor_per_level) }
	it { should respond_to(:magic_resist_per_level) }
	it { should respond_to(:movespeed) }

	it { should_not respond_to(:ability_power) }
	it { should_not respond_to(:role) }
	it { should_not respond_to(:range) }
	it { should_not respond_to(:catch_rate) }

	it { should be_valid }

	describe "when champ_name is not present" do
		before { @table_champion.name = " " }
		it { should_not be_valid }
	end

	describe "when health is too high" do
		it "should be invalid" do
			@table_champion.health = 300
			expect(@table_champion).not_to be_valid
		end
	end

	describe "when given a role not on the list" do
		it "should be invalid" do
			@table_champion.role = "Caster"
			expect(@table_champion).not_to be_valid
		end
	end

	describe "when range is too high" do
		it "should be invalid" do
			@table_champion.range = 11
			expect(@table_champion).not_to be_valid
		end
	end
end
