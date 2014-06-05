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
			before do
				sign_in FactoryGirl.create(:user)
				visit roster_path
			end

			it { should have_title('Edit Roster') }
			it { should have_content('Current Roster') }
		end
		describe "not signed in" do
			before { visit roster_path }
			it { should have_link('Sign in') }
		end
	end

end