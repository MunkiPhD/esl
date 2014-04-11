require 'spec_helper'

feature "user logs a food item" do
  let(:food) { create(:bread) }
  let(:user) { create(:user) }

  context 'visitors' do
    scenario 'attempts to log food, is redirected' do
      visit food_path(food)
      click_link 'Log Item'
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context 'logged in users' do
    before :each do 
      login_user user
    end

    scenario "user searches for a food and logs it" do
      visit foods_path
      fill_in 'search', with: food.name
      click_button 'Search'
      click_link food.name
      expect(page).to have_content food.name
      click_link 'Log Item'
      fill_in 'Servings', with: "1"
      select_date '2014,January,2', from: 'Log Date'
      click_button 'Log'
      expect(page).to have_content "Logged 1 servings of #{food.name}"
    end

  end
end
