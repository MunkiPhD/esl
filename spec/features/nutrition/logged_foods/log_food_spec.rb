require 'spec_helper'

feature "User food item logging" do
  let(:food) { create(:bread) }
  let(:user) { create(:user) }

  context 'visitor' do
    scenario 'attempts to log food, is redirected' do
      visit food_path(food)
      click_link 'Log Item'
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context 'logged in user' do
    before :each do 
      login_user user
    end

    scenario "viewing the index displays all the instances of that food logged" do
      logged_food = create(:log_food, user: user, log_date: Date.today, food: food)
      logged_food2 = create(:log_food, user: user, log_date: Date.yesterday, food: create(:food))
      visit food_log_foods_path(food_id: food)
      expect(page).to have_content food.name
      expect(page).to_not have_content logged_food2.food_name
    end

    scenario "searches for a food and logs it" do
      visit foods_path
      fill_in 'search', with: food.name
      click_button 'Search'
      click_link food.name
      expect(page).to have_content food.name
      click_link 'Log Item'
      fill_in 'Servings', with: "1"
      select_date '2014,January,2', from: 'Log Date'
      click_button 'Log'
      expected_str = "Logged 1.0 servings of #{food.name}"
      expect(page).to have_content expected_str
    end

    scenario 'has food default to todays date and a serving size of 1' do
      food = create(:food)
      visit new_food_log_food_path(food_id: food)

      expect(find_by_id('log_food_servings').value).to eq "1.0"

      todays_date = Date.today
      expect(find_by_id('log_food_log_date_3i').value).to eq todays_date.day.to_s
      expect(find_by_id('log_food_log_date_2i').value).to eq todays_date.month.to_s
      expect(find_by_id('log_food_log_date_1i').value).to eq todays_date.year.to_s
    
    end

    scenario 'after logging a food item, it appears in the nutrition dashboard' do
      food = create(:food)
      visit nutrition_path
      expect(page).to_not have_content food.name
      visit new_food_log_food_path(food_id: food)
      click_button 'Log'
      visit nutrition_path
      expect(page).to have_content food.name
    end

    scenario 'edits a food item' do
     pending 
    end

  end
end
