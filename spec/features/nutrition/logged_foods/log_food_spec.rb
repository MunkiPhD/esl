require 'rails_helper'

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

		scenario "edits a logged food item" do
			Timecop.freeze(Date.parse("12-April-2014")) do
				logged_food = create(:log_food, user: user, log_date: Date.parse("12-April-2014"), servings: 1)
				visit nutrition_path
				select '12', from: 'log_date_day'
				select 'April', from: 'log_date_month'
				select '2014', from: 'log_date_year'
				click_button 'Go'
				within first('.food-item') do
					click_edit_link
				end

				#click_link "Edit"
				fill_in 'Servings', with: "2.25"
				select_date '2013,January,2', from: 'Log Date'
				click_button 'Update'

				expect(page).to have_content "Successfully updated food log entry!"
				visit log_food_path(logged_food)
				expect(find_by_id("servings")).to have_content "2.25"
				expect(find_by_id("log_date")).to have_content "over 1 year ago"
			end
		end

		scenario "deletes a log entry from the nutrition dashboard" do
			# this test does not take into account JS that has been added on the front end
			logged_food = create(:log_food, user: user, log_date: Date.parse("12-April-2014"), servings: 1)
			visit nutrition_path
			select '12', from: 'log_date_day'
			select 'April', from: 'log_date_month'
			select '2014', from: 'log_date_year'
			click_button 'Go'

			expect(page).to have_content logged_food.food_name
			#first('.food-item').click_link('Delete')
			within first('.food-item') do
				click_delete_link
			end

			expect(page).to have_content "Food log entry deleted."
			expect(page).to_not have_content logged_food.food_name
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

		scenario 'nutrition dashboard displays the entry name and macronutrient summary after a log' do
			food = create(:food, protein: 10, carbs: 20, total_fat: 30)
			visit nutrition_path
			expect(page).to_not have_content food.name
			visit new_food_log_food_path(food_id: food)

			fill_in "Servings", with: "2"
			click_button "Log"

			visit nutrition_path
			within('#logged_foods .food-item') do
				expect(page).to have_content food.name
				expect(page).to have_content "Protein: 20.0g"
				expect(page).to have_content "Carbs: 40.0g"
				expect(page).to have_content "Fat: 60.0g"
			end
		end

		scenario 'can go to the logged food from the nutrition dashboard' do
			logged_food = create(:log_food, user: user, log_date: Date.today)
			visit nutrition_path
			click_link logged_food.food_name
			expect(page).to have_content logged_food.food_name
		end
	end

end
