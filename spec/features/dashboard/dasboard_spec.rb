require 'rails_helper'

feature 'dasboard' do
	let(:user) { create(:user) }
	before :each do
		login_user user
	end

	scenario 'is accessible by clicking dashboard on the naviation' do
		visit nutrition_path
		click_link "dashboard"
		expect(page).to have_content "Dashboard"
	end

	scenario 'has the ability to search for food items' do
		visit root_path
		food = create(:food, name: "beef")

		within("#nutrition_search_box") do
			fill_in 'search', with: "beef"
			click_button "Search"
		end

		expect(page).to have_link "beef"
	end

	scenario 'displays the link to log a workout' do
		visit root_path
		within("#workouts") do
			expect(page).to have_link "Workout"
			click_link "Workout"
		end

		expect(page).to have_content "Logging a new Workout"
	end

	scenario 'if a user has workout templates, it displays the link to view workout templates' do
		template = create(:workout_template, user: user)
		visit root_path
		within("#workouts") do
			expect(page).to have_link "Template Workout"
			click_link "Template Workout"
		end
		expect(page).to have_content "Workout Templates"
		expect(page).to have_link template.title
	end
end
