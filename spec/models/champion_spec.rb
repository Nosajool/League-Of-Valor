require 'spec_helper'

describe Champion do
	let(:user){ FactoryGirl.create(:user) }
	before do
		@champion = user.champions.build( table_champion_id: 2,
								  		 experience: 1,
								 		 level: 1,
								 		 user_id: 1,
								 		 position: 3,
								 		 skin: 1000000000,
								 		 active_skin: 0 )
	end

	subject { @champion }

	it { should respond_to(:table_champion_id) }
	it { should respond_to(:experience) }
	it { should respond_to(:level) }
	it { should respond_to(:user_id) }
	it { should respond_to(:position) }
	it { should respond_to(:skin) }
	it { should respond_to(:active_skin) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @champion.user_id = nil }
		it { should_not be_valid }
	end

	describe "when position is too high" do
		it "should be invalid" do
			@champion.position = 6
			expect(@champion).not_to be_valid
		end
	end

	describe "when skin code is too low" do
		it "should be invalid" do
			@champion.skin = 123
			expect(@champion).not_to be_valid
		end
	end

	describe "when active_skin is too high" do
		it "should be invalid" do
			@champion.active_skin = 11
			expect(@champion).not_to be_valid
		end
	end
end
