require 'spec_helper'

feature "User manages a food item" do
  let(:user) { create(:user) }
  let(:ice_cream) { build(:ice_cream) }
  let(:bread) { create(:bread) }

  scenario "by creating a new food with valid information" do
    login_user user

    visit "nutrition/foods/new"
    fill_in "Name", with: ice_cream.name
    fill_in "Brand", with: ice_cream.brand
    fill_in "Calories", with: ice_cream.calories
    fill_in "Protein", with: ice_cream.protein

    expect {
      click_button "Create Food"
    }.to change(Food, :count).by(1)

    expect(page).to have_content ice_cream.name
    expect(page).to have_content ice_cream.brand
    expect(page).to have_content ice_cream.protein
  end

  scenario "creates a new food with invalid information" do
    pending
  end

  scenario "views an existing food" do
    visit food_path(bread)
    expect(page)
  end

  scenario "edits an existing food" do
    pending
  end

  scenario "deletes a food that has not been logged by ANYONE" do
    pending
  end

  scenario "attempts to delete a food that HAS been logged by someone" do
    pending
  end
end
