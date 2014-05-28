require 'spec_helper'

describe "Champion List" do

	subject { page }

	describe "signed in" do
		before do
			sign_in FactoryGirl.create(:user)
			visit champions_path
		end

		it { should have_title('Champions List') }
		it { should have_content('List of Champions') }
	end

	describe "not signed in" do
		before do
			visit champions_path
		end
		it { should have_link('Sign in') }
	end
end