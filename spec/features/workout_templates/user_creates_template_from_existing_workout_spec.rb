require 'rails_helper'

feature 'User creates a single workout template' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'by copying an existing workout' do
		workout = create(:workout, user: user)
		visit workout_path(workout)

		click_link "Create Template"

		expect(page).to have_content "Creating a template from: #{workout.title}"

		workout.workout_exercises.each do |workout_exercise|
			expect(page).to have_content workout_exercise.exercise_name
		end

		fill_in "workout_title", with: "some workout template"

		click_button "Save Workout"

		expect(page).to have_link "some workout template"
	end
end
