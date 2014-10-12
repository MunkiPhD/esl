require 'rails_helper'

feature 'dasboard' do
	let(:user) { create(:user) }
	before :each do
		login_user user
	end

	scenario 'it displays the current date being looked at' do
		Timecop.freeze(Date.today) do
			visit root_path
			expect(page).to have_content format_date(Date.today)
		end
	end

	scenario 'is accessible by clicking dashboard on the naviation' do
		visit nutrition_path
		click_link "dashboard"
		expect(page).to have_content "Nutrition"
		expect(page).to have_content "Workouts"
		expect(page).to have_content "My Circles"
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
			expect(page).to have_link "Workout from Template"
			click_link "Workout from Template"
		end
		expect(page).to have_content "Workout Templates"
		expect(page).to have_link template.title
	end

	scenario 'if a user has NO workout templates, it displays a link to create workout template' do
		expect(user.workout_templates.count).to eq 0

		visit root_path
		within("#workouts") do
			expect(page).to have_link "Create Workout Template"
			click_link "Create Workout Template"
		end

		expect(page).to have_content "Creating a Workout Template"
	end

	scenario 'it displays links to workouts that have been logged for todays date' do
		Timecop.freeze(Date.today) do
			expect(user.workouts.on_date(Date.today).count).to eq 0
			workout = create(:workout, date_performed: Date.today, user: user)
			visit root_path
			within("#workouts") do
				expect(page).to have_link workout.title
			end
		end
	end
end
