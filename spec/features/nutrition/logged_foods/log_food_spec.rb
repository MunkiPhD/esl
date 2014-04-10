require 'spec_helper'

feature "user logs a food item" do
  let(:food) { create(:bread) }

  scenario "user searches for a food and logs it" do
    visit foods_path
    fill_in 'search', with: food.name
    click_button 'Search'
    click_link food.name
    expect(page).to have_content food.name
    click_link 'Log Item'
    fill_in 'Servings', with: "1"
    fill_in 'Date', with: Date.today.to_s
    click_button 'Log'
    expect(page).to have_content "Logged 1 serving of #{food.name}"
  end
end
