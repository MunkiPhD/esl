require 'spec_helper'

feature "User manages favorite foods" do
  let(:user) { create(:user) }

  before :each do
    login_user user
  end

  scenario "Can add a food to favorites from the food items page" do
    food = create(:food)
    visit food_path(food)

    click_button "Add to Favorites"
    expected_str = "#{food.name} was added to your favorites"
    expect(page).to have_content expected_str

    visit nutrition_path
    click_link "View your Favorites"
    within("#favorite_foods_list") do
      expect(page).to have_link food.name
    end
  end

  scenario "Logs a food entry from their favorites list" do
    food = create(:food)
    visit food_path(food)
    click_button "Add to Favorites"

    visit nutrition_path
    click_link "View your Favorites"

    within("#favorite_foods_list") do
      click_link "Log Item"
    end

    fill_in "Servings", with: "1.2"
    click_button "Log"

    within("#logged_foods") do
      expect(page).to have_link food.name
      expect(page).to have_content "1.2 Servings"
    end
  end


  scenario "Only sees favorite foods that belong to them" do
    food = create(:bread)
    favorite_food_one = create(:favorite_food, food: food, user: create(:user))
    favorite_food_mine = create(:favorite_food, user: user)

    visit favorite_foods_path
    within("#favorite_foods_list") do
      expect(page).to have_link favorite_food_mine.food_name
      expect(page).to_not have_link favorite_food_one.food_name
    end
  end

  scenario "User can remove an item from their favorites page" do
    favorite_food = create(:favorite_food, user: user)
    visit favorite_foods_path

    within("#favorite_foods_list") do
      expect(page).to have_link favorite_food.food_name
      click_button "Remove"
    end

    expected_str = "#{favorite_food.food_name} was removed from your favorites"
    expect(page).to have_content expected_str

    visit favorite_foods_path
    within("#favorite_foods_list") do
      expect(page).to_not have_link favorite_food.food_name
    end
  end


  scenario 'removes the food from favorites from the food items page' do
    food = create(:food)
    visit food_path(food)

    expect(page).to_not have_button "Remove from Favorites"
    click_button "Add to Favorites"
    
    visit food_path(food)

    expect(page).to_not have_button "Add to Favorites"
    click_button "Remove from Favorites"

    expected_str = "#{food.name} was removed from your favorites"
    expect(page).to have_css ".text-success", text: expected_str
    
    visit favorite_foods_path
    within("#favorite_foods_list") do
      expect(page).to_not have_link food.name
    end
  end

  scenario 'only shows the option to remove a favorite if it is already a favorite of user' do
    food = create(:food)
    favorite_food = create(:favorite_food, user: create(:user), food: food)

    visit favorite_foods_path
    within("#favorite_foods_list") do
      expect(page).to_not have_link food.name
    end

    visit food_path(food)
    expect(page).to_not have_button "Remove from Favorites"
    expect(page).to have_button "Add to Favorites"
  end
end
