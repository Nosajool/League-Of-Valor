require 'spec_helper'

describe Map do
	before do
		@map = Map.new( map_name: "Valoran",
						description: "Valoran was founded in 2014")
	end

	subject { @map }

	it { should respond_to(:map_name) }
	it { should respond_to(:description) }
	it { should be_valid }

	describe "when map name is not present" do
		before { @map.map_name = " " }
		it { should_not be_valid }
	end

	describe "when map description is not present" do
		before { @map.description = " " }
		it { should_not be_valid }
	end
end
