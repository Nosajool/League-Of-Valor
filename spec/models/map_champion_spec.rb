require 'spec_helper'

describe MapChampion do
	before do
		@map_champion = MapChampion.new( map_id: 1,
									     probability: 45,
									     key: "Aatrox")
	end

	subject { @map_champion }

	it { should respond_to(:map) }
	it { should respond_to(:probability) }
	it { should respond_to(:key) }
	it { should be_valid }

	describe "when key is missing" do
		it "should be invalid" do
			@map_champion.key = " "
			expect(@map_champion).not_to be_valid
		end
	end

	describe "when probability is too high" do
		it "should be invalid" do
			@map_champion.probability = 101
			expect(@map_champion).not_to be_valid
		end
	end
end
