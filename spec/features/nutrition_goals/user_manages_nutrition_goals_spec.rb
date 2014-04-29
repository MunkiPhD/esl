require 'spec_helper'

feature 'User manages nutrition goals' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'visits nutrition dasbboard and sees default values for daily goals' do
		visit nutrition_path

		within '#nutrition_goals' do
			expect(page).to have_content 'Daily Goals'
			within '.calorie-goal' do
				expect(page).to have_content 'Calories'
				expect(page).to have_content '0 / 2000'
			end
			within '.protein-goal' do
				expect(page).to have_content 'Protein'
				expect(page).to have_content '0 / 50'
			end
			within '.carbs-goal' do
				expect(page).to have_content 'Carbs'
				expect(page).to have_content '0 / 300'
			end
			within '.fat-goal' do
				expect(page).to have_content 'Fat'
				expect(page).to have_content '0 / 65'
			end
			expect(page).to have_link 'Manage Goals'
		end
	end

	scenario 'modifies their current goal' do
		visit nutrition_path
		within '#nutrition_goals' do
			click_link "Manage Goals"
		end

		expect(page).to have_content "Modifying Daily Nutrition Goals"
		protein = 100
		carbs = 200
		fat = 300

		fill_in "Protein", with: protein
		fill_in "Carbs", with: carbs
		fill_in "Total fat", with: fat

		click_button "Update Goals"
		calorie_total = (protein * 4) + (carbs * 4) + (fat * 9)
		expected_calorie_str = "0 / #{calorie_total}"

		within '#nutrition_goals' do
			within '.calorie-goal' do
				expect(page).to have_content expected_calorie_str
			end
			within '.protein-goal' do
				expect(page).to have_content '0 / 100'
			end
			within '.carbs-goal' do
				expect(page).to have_content '0 / 200'
			end
			within '.fat-goal' do
				expect(page).to have_content '0 / 300'
			end
		end
	end
end
