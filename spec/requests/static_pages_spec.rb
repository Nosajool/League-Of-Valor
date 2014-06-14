require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
    before { visit root_path }
    it "should have the content 'League of Valor'" do
      expect(page).to have_content('League of Valor')
    end

    it "should have the base title" do
      expect(page).to have_title("League of Valor")
    end

    it "should not have a custom page title" do
      expect(page).not_to have_title('| Home')
    end

    it "should have the git issues tracker" do
      expect(page).to have_content('Links to Bugs & Issues fixed')
    end
  end

  describe "Help page" do
    before { visit help_path }
    it "should have the content 'Help'" do
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      expect(page).to have_title("League of Valor | Help")
    end
  end

  describe "About page" do
    before { visit about_path }
    it "should have the content 'About Us'" do
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      expect(page).to have_title("League of Valor | About Us")
    end
  end

  describe "Contact page" do
    before { visit contact_path }
    it "should have the content 'Contact'" do
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      expect(page).to have_title("League of Valor | Contact")
    end
  end
end