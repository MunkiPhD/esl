require 'spec_helper'

feature "user visits the dashboard" do
  context 'valid user' do
    let(:user) { create(:user) }

    before :each do
      login_user user
    end

    scenario 'user access the nutrition dashboard from the main screen and sees no logged foods for the day' do
      visit root_path
      click_link "nutrition"
      expect(page).to have_content "Nutrition Dashboard"
      expect(page).to have_content "No foods logged yet for today!"
    end
  end
end
