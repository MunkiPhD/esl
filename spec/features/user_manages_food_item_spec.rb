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
    expect(page).to have_content "Food was successfully created."
  end

  scenario "cannot create a food with invalid information" do
    login_user

    visit "nutrition/foods/new"

    fill_in "Name", ""
    fill_in "Brand", with: ice_cream.brand
    fill_in "Calories", ""
    fill_in "Protein", with: ice_cream.protein

    expect {
      click_button "Create Food"
    }.to change(Food, :count).by(0)

    expect(page).to have_text "Invalid Name"
    expect(page).to have_text "Calories must be a number"
  end

  scenario "views an existing food" do
    visit food_path(bread)

    expect(page).to have_text bread.name
    expect(page).to have_text bread.calories
    expect(page).to have_text bread.brand
  end

  scenario "edits an existing food" do
    login_user
    visit food_path(bread)
    expect(page).to have_link "Edit"

    click_link "Edit"

    expect(page).to have_text "Editing #{bread.name}"
    fill_in "Name", with: "Bread2"
    fill_in "Brand", with: "Publix"

    click_button "Update"
    expect(page).to have_text "Bread2"
    expect(page).to have_text "Publix"

    expect(page).to have_text "Successfully updated #{bread.name}"
  end

  scenario "deletes a food that has not been logged by ANYONE" do
    pending "this has to be implemented when implementing the food logging scheme"
  end

  scenario "attempts to delete a food that HAS been logged by someone" do
    pending "this has to be implemented when implementing the food logging scheme"
  end
end
