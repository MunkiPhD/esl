require 'rails_helper'

feature 'Visitors manage templates' do
	scenario 'can view a template' do
		template = create(:workout_template_with_exercises, user: create(:user))
		visit workout_template_path(template)

		expect(page).to have_link "login"
		expect(page).to have_content template.title
		template.workout_exercise_templates.each do |we|
			expect(page).to have_content we.exercise_name
		end
	end

	scenario 'attempts to create a template and is redirected' do
		visit new_workout_template_path
		expect(page).to have_content "You need to sign in or sign up"
	end

	scenario 'attempts to edit a template and is redirected' do
		template = create(:workout_template)
		visit edit_workout_template_path(template)

		expect(page).to have_content "You need to sign in or sign up"
	end

	scenario 'attempts to delete a template and is redirected' do
		template = create(:workout_template)
		visit workout_template_path(template)
		
		click_button "Delete Template"
		expect(page).to have_content "You need to sign in or sign up"		
	end
end
