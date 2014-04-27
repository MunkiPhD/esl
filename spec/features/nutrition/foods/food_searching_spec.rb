require 'spec_helper'

feature "Person searching for food" do
  scenario "searches for a food item" do
    bread = create(:bread)

    perform_search("bread")

    expect(page).to have_link bread.name
    expect(page).to have_content "Search for 'bread' found 1 result."
  end

  scenario "recieves more than one result" do
    bread = create(:bread)
    bread2 = create(:bread, name: "Sourdough Bread")

    perform_search("bread")
		

    expect(page).to have_link bread.name
    expect(page).to have_link bread2.name
    expect(page).to have_content "Search for 'bread' found 2 results."
  end

  def perform_search(terms)
    visit search_food_path
    expect(page).to have_text "Search for a food!"

    fill_in "search", with: terms
    click_button "Search"
  end
end
