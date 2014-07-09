require 'spec_helper'

describe "Champion Pages" do

	subject { page }
	describe "Champion Table Page" do
		describe "signed in" do
			before do
				sign_in FactoryGirl.create(:user)
				visit champions_path
			end

			it { should have_title('Champions List') }
			it { should have_content('List of Champions') }
		end

		describe "not signed in" do
			before { visit champions_path }
			it { should have_link('Sign in') }
		end	
	end


	describe "Roster Page" do
		describe "signed in" do
			let(:user) { FactoryGirl.create(:user) }
			let!(:c1) { FactoryGirl.create(:champion,
									   user: user,
									   position: 1,
									   table_champion_id: 7) }
			before do
				sign_in(user)
				visit roster_path
			end

			it { should have_title('Edit Roster') }
			it { should have_content('Current Roster') }
			# Table Champion ID 7 = Ryze
			it { should have_content('Ryze') }
			# Since there are 4 swaps, shoud have empty champions
			it { should have_content('Empty') }
		end
		describe "not signed in" do
			before { visit roster_path }
			it { should have_link('Sign in') }
		end
	end

	describe "Bench Page" do
		describe "signed in" do
			let(:user) { FactoryGirl.create(:user) }
			let!(:c1) { FactoryGirl.create(:champion,
										   user: user,
										   position: 0) }
			before do
				sign_in(user)
				visit bench_path
			end

			it { should have_title('Bench') }
			it { should have_content('Bench') }
			it { should have_link('Change Roster') }
		end
		describe "not signed in" do
			before { visit roster_path }
			it { should have_link('Sign in') }
		end
	end

end