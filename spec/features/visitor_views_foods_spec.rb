require 'spec_helper'

feature "Visitor interacts with food" do
  let(:bread) { create(:bread) }

  scenario "views a food item" do
    visit food_path(bread)

    expect(page).to have_text bread.name
    expect(page).to have_text bread.calories
    expect(page).to have_text "login"
    expect(page).to have_link "Log this"
  end

  scenario "attempts to create an item" do
    visit new_food_path
    redirects_to_sign_in
  end

  scenario "attempts to edit a food item" do
    visit edit_food_path(bread)
    redirects_to_sign_in
  end


  scenario "attempts to log a food item" do
    pending "need path to log a food item"
    redirects_to_sign_in
  end

  scenario "searches for a food item" do
    visit search_food_path
    expect(page).to have_text "Search for a food!"

    fill_in "search", with: "bread"
    click_button "Search"

    expect(page).to have_content "Searched for: 'bread'"
    expect(page).to have_content bread.name
  end

  def redirects_to_sign_in
    expect(current_path).to eq new_user_session_path
    expect(page).to have_text "You need to sign in or sign up before continuing."
    expect(page).to have_text "Sign up"
    expect(page).to have_button "Sign in"
  end
end 
