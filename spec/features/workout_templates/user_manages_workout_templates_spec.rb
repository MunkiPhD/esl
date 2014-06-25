require 'rails_helper'

feature 'User can manage workout templates' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'goes to workout templates page from the workouts page' do
		visit workouts_path
		click_link "My Templates"

		expect(page).to have_content "Workout Templates"
	end

	scenario 'can view a list of all their templates' do
		template = create(:workout_template, user: user)
		visit workout_templates_path
		expect(page).to have_content template.title
	end

	scenario 'can view a workout template' do
		template = create(:workout_template_with_exercises, user: user)
		visit workout_templates_path
		click_link template.title

		expect(template.workout_exercise_templates.size).to eq 2
		expect(page).to have_content template.title

		template.workout_exercise_templates.each do |wet|
			expect(page).to have_content wet.exercise_name
		end
	end
	
end
