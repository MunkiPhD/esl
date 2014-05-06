require 'spec_helper'

feature 'User manages nutrition goals' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'visits nutrition dashboard and sees default values for daily goals' do
		visit nutrition_path

		within '#nutrition_goals' do
			expect(page).to have_content 'Daily Goals'
			within '.calories-goal' do
				expect(page).to have_content 'Calories'
				expect(page).to have_content '0 / 2000 kCal'
			end
			within '.protein-goal' do
				expect(page).to have_content 'Protein'
				expect(page).to have_content '0g / 50g'
			end
			within '.carbs-goal' do
				expect(page).to have_content 'Carbs'
				expect(page).to have_content '0g / 300g'
			end
			within '.total_fat-goal' do
				expect(page).to have_content 'Total Fat'
				expect(page).to have_content '0g / 65g'
			end
			expect(page).to have_link 'Manage Goals'
		end
	end

	scenario 'modifies their current goals' do
		visit nutrition_path
		within '#nutrition_goals' do
			click_link "Manage Goals"
		end

		expect(page).to have_content "Modifying Daily Nutrition Goals"
		protein = 100
		carbs = 200
		fat = 300
		calorie_total = (protein * 4) + (carbs * 4) + (fat * 9)

		fill_in "nutrition_goal_calories", with: calorie_total
		fill_in "Protein", with: protein
		fill_in "Carbs", with: carbs
		fill_in "Total fat", with: fat

		click_button "Update Goals"
		expected_calorie_str = "0 / #{calorie_total}"

		within '#nutrition_goals' do
			within '.calories-goal' do
				expect(page).to have_content expected_calorie_str
			end
			within '.protein-goal' do
				expect(page).to have_content '0g / 100g'
			end
			within '.carbs-goal' do
				expect(page).to have_content '0g / 200g'
			end
			within '.total_fat-goal' do
				expect(page).to have_content '0g / 300g'
			end
		end
	end

	scenario 'logging a food item modifies the current progress of the goal' do
		Timecop.freeze(Date.today) do
			food = create(:food, protein: 1, carbs: 2, total_fat: 3)
			logged_food = create(:log_food, user: user, food: food, servings: 1, log_date: Date.today)

			visit nutrition_path

			within '#nutrition_goals' do
				within '.calories-goal' do
					expect(page).to have_content '39 / 2000 kCal'
				end
				within '.protein-goal' do
					expect(page).to have_content '1g / 50g'
				end
				within '.carbs-goal' do
					expect(page).to have_content '2g / 300g'
				end
				within '.total_fat-goal' do
					expect(page).to have_content '3g / 65g'
				end
			end
		end
	end
end
