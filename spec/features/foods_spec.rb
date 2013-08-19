require 'spec_helper'

feature "Foods" do
  let(:user) { create(:user) }
  let(:ice_cream) { build(:ice_cream) }

  scenario "User creates a new food" do
    login_user user

    visit "/foods/new"
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

  scenario "User can view an existing food" do
    pending
  end

  scenario "User edits an existing food" do
    pending
  end

  scenario "User can delete a food IF it is not logged by ANYONE" do
    pending
  end

  scenario "User can search for a food by name and it shows the results" do
    pending
  end
end
