require 'spec_helper'

feature "User manages a food item" do
  let(:user) { create(:user) }
  let(:ice_cream) { build(:ice_cream) }
  let(:bread) { create(:bread) }

  before(:each) do
    login_user user
  end

  scenario "by creating a new food with valid information" do
    visit new_food_path #"nutrition/foods/new"

    expect {
      fill_in "Name", with: ice_cream.name
      fill_in "Brand", with: ice_cream.brand
      fill_in "Calories", with: ice_cream.calories
      fill_in "Protein", with: ice_cream.protein
      fill_in "Serving size", with: "1 scoop"

      click_button "Create Food"
    }.to change(Food, :count).by(1)

    expect(page).to have_content ice_cream.name
    expect(page).to have_content ice_cream.brand
    expect(page).to have_content ice_cream.protein
    expect(page).to have_content "Food was successfully created."
  end

  scenario "cannot create a food with invalid information" do
    visit new_food_path #"nutrition/foods/new"

    fill_in "Name", with: ""
    fill_in "Brand", with: ice_cream.brand
    fill_in "Calories", with: ""
    fill_in "Protein", with: ice_cream.protein

    expect {
      click_button "Create Food"
    }.to change(Food, :count).by(0)

    expect(page).to have_text "Name can't be blank"
    expect(page).to have_text "Name is too short"
    expect(page).to have_text "Calories is not a number"
  end

  scenario "views an existing food" do
    visit food_path(bread)

    expect(page).to have_text bread.name
    expect(page).to have_text bread.calories
    expect(page).to have_text bread.brand
  end

  scenario "edits an existing food" do
    visit food_path(bread)
    expect(page).to have_link "Edit"

    click_link "Edit"

    expect(page).to have_text "Editing #{bread.name}"
    fill_in "Name", with: "Bread2"
    fill_in "Brand", with: "Publix"

    click_button "Update Food"
    expect(page).to have_text "Bread2"
    expect(page).to have_text "Publix"

    expect(page).to have_text "Food successfully updated!"
  end

  scenario "deletes a food that has not been logged by ANYONE" do
    pending "this has to be implemented when implementing the food logging scheme"
  end

  scenario "attempts to delete a food that HAS been logged by someone" do
    pending "this has to be implemented when implementing the food logging scheme"
  end


	scenario 'can attach an image to food item' do
    visit new_food_path #"nutrition/foods/new"

    expect {
      fill_in "Name", with: ice_cream.name
      fill_in "Brand", with: ice_cream.brand
      fill_in "Calories", with: ice_cream.calories
      fill_in "Protein", with: ice_cream.protein
      fill_in "Serving size", with: "1 scoop"
			attach_file "Food image", "#{Rails.root}/spec/fixtures/ron.jpg"

      click_button "Create Food"
		}.to change(Food, :count).by(1)		

		expect(page.find("#food_image")['src']).to_not have_content "medium/apple.png"
		expect(page.find("#food_image")['src']).to have_content "ron.jpg"
	end
end
