require 'rails_helper'

feature "User manages favorite foods" do
  let(:user) { create(:user) }

  before :each do
    login_user user
  end

	scenario 'user sees message if no foods marked as favorite' do
		visit favorite_foods_path
		expect(page).to have_content "You currently have no favorite foods!"
	end

  scenario "Can add a food to favorites from a food items page" do
    food = create(:food)

		add_food_to_favorites(food)

    visit nutrition_path
    click_link "View your Favorites"
    within("#favorite_foods_list") do
      expect(page).to have_link food.name
    end
  end

	scenario 'Favoriting a food displays a flash messages' do
		food = create(:food)
		add_food_to_favorites(food)

		user_sees_message "#{food.name} was added to your favorites"
	end


  scenario "Logs a food entry from their favorites list" do
    food = create(:food)

		add_food_to_favorites(food)

    visit nutrition_path
    click_link "View your Favorites"

    within("#favorite_foods_list") do
      click_link "Log Item"
    end

    fill_in "Servings", with: "1.2"
    click_button "Log"

    within("#logged_foods") do
      expect(page).to have_link food.name
      expect(page).to have_content "1.2 servings"
    end
  end


  scenario 'can go to an item from the favorites food list' do
    food = create(:food)

		add_food_to_favorites(food)

		go_to_food_from_favorites(food)

    expect(page).to have_content food.name
    user_sees_button "Remove from Favorites"
  end



  scenario "Only sees favorite foods that belong to them" do
    food = create(:bread)
    favorite_food_one = create(:favorite_food, food: food, user: create(:user))
    favorite_food_mine = create(:favorite_food, user: user)

		user_does_not_see_food_in_favorites_list(food)
		user_sees_food_in_favorites_list(favorite_food_mine.food)
  end


  scenario "User can remove an item from their favorites page" do
    favorite_food = create(:favorite_food, user: user)
    visit favorite_foods_path

    within("#favorite_foods_list") do
      expect(page).to have_link favorite_food.food_name
		click_remove_button
    end

    user_sees_message "#{favorite_food.food_name} was removed from your favorites"
	 user_does_not_see_food_in_favorites_list(favorite_food.food)
  end


  scenario 'removes the food from favorites from the food items page' do
    food = create(:food)
    visit food_path(food)

    user_does_not_see_button "Remove from Favorites"
    click_button "Add to Favorites"
    
    visit food_path(food)
    user_does_not_see_button "Add to Favorites"
    click_button "Remove from Favorites"

    user_sees_message "#{food.name} was removed from your favorites"
    
		user_does_not_see_food_in_favorites_list(food)
  end

  scenario 'only shows the option to remove a favorite if it is already a favorite of user' do
    food = create(:food)
    favorite_food = create(:favorite_food, user: create(:user), food: food)

		user_does_not_see_food_in_favorites_list(food)

		visit food_path(food)
		user_does_not_see_button("Remove from Favorites")
		user_sees_button("Add to Favorites")
  end

	def user_sees_food_in_favorites_list(food)
    visit favorite_foods_path
    within("#favorite_foods_list") do
      expect(page).to have_link food.name
    end
	end

	def user_does_not_see_food_in_favorites_list(food)
    visit favorite_foods_path
    within("#favorite_foods_list") do
      expect(page).to_not have_link food.name
    end
	end

	def user_sees_message(message)
    expect(page).to have_css "#flash_messages", text: message
	end

	def user_sees_button(button_text)
		expect(page).to have_button button_text
	end


	def user_does_not_see_button(button_text)
		expect(page).to_not have_button button_text
	end


	def go_to_food_from_favorites(food)
    visit nutrition_path
    click_link "View your Favorites"

    within("#favorite_foods_list") do
      click_link food.name
    end
	end


	def add_food_to_favorites(food)
		visit food_path(food)
		click_button "Add to Favorites"
	end

  def click_remove_button
	  find(:css, 'button[name="Remove"]').click
  end
end
