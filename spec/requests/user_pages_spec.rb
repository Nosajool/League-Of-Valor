require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "index" do
		before do
			sign_in FactoryGirl.create(:user)
			FactoryGirl.create(:user, username: "Bob", email: "bob@example.com")
			FactoryGirl.create(:user, username: "Ben", email: "ben@example.com")
			visit users_path
		end

		it { should have_title('All users') }
		it { should have_content('All users') }

		describe "pagination" do
			
			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			it { should have_selector('div.pagination') }

			it "shold list each user" do
				User.paginate(page: 1).each do |user|
					expect(page).to have_selector('li', text: user.username)
				end
			end
		end

		it "should list each user" do
			User.all.each do |user|
				expect(page).to have_selector('li', text: user.username)
			end
		end
	end
	
	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
	end

	describe "signup" do
		
		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Username",         with: "Example"
				fill_in "Email",            with: "user@example.com"
				fill_in "Password",         with: "foobar"
				fill_in "Confirmation",     with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'user@example.com') }

				it { should have_link('Sign out') }
				it { should have_title(user.username) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do
			it { should have_content("Update your profile") }
			it { should have_title("Edit user") }
		end

		describe "with invalid information" do
			before { click_button "Save changes" }

			it { should have_content('error') }
		end

		describe "with valid information" do
			let(:new_email) { "new@example.com" }
			before do
				fill_in "Email",                with: new_email
				fill_in "Password",             with: user.password
				fill_in "Confirm Password",     with: user.password
				click_button "Save changes"
			end

			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Sign out', href: signout_path) }
			specify { expect(user.reload.email).to eq new_email }
		end
	end


	describe "profile page" do
		# Needs fixing
		let(:user) { FactoryGirl.create(:user) }

		let!(:c1) { FactoryGirl.create(:champion, user: user) }
		let!(:c2) { FactoryGirl.create(:champion, user: user,
												  table_champion_id: 2,
												  experience: 100,
												  level: 5,
												  position: 3,
												  skin: 1000000000,
												  active_skin: 5) }
		before do
			sign_in(user)
			visit user_path(user)
		end

		it { should have_content(user.username) }
		it { should have_title(user.username) }
		it { should have_link('Sign out') }

		describe "champions" do
			it { should have_content(c1.position) }
			it { should have_content(c2.position) }
			it { should have_content(user.champions.count) }
		end
	end
end
