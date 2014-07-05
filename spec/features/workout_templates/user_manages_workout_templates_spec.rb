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
	
	scenario 'can create a new workout template' do
		exercise = create(:exercise) 
		visit workout_templates_path
		click_link "New Template"

		template = build(:workout_template)
		fill_in "workout_template_title", with: template.title
		
    last_nested_exercise = all(".workouts_workout_exercise").last

    within(last_nested_exercise) do
      select exercise.name, from: 'workout_template_workout_exercise_templates_attributes_0_exercise_id'
      fill_in "workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_rep_count", with: "2"
      #fill_in "workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_weight", with: "225"
			check	"workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_is_percent_of_one_rep_max"
			fill_in "workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_percent_of_one_rep_max", with: "85"
    end

    expect {
      click_button "Save Workout Template"
    }.to change(WorkoutTemplate, :count).by(1)

		expect(page).to have_content "Workout template created."
    expect(page).to have_link template.title
	end

	scenario 'can edit a template' do
		workout_template = create(:workout_template_with_exercises, user: user)
		visit workout_templates_path
		
		click_link workout_template.title
		click_link "Edit Template"

		fill_in "Title", with: "Updated Title"
		fill_in "workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_weight", with: "333"
		uncheck	"workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_is_percent_of_one_rep_max"
		#fill_in "workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_percent_of_one_rep_max", with: "85"

		click_button "Save Workout Template"

		expect(page).to have_content "Updated Title"
		expect(page).to have_content "333"
	end

	scenario 'can delete a template' do
		workout_template = create(:workout_template_with_exercises, user: user)
		visit workout_template_path(workout_template)

		expect {
			click_button "Delete Template"
		}.to change(WorkoutTemplate, :count).by(-1)

		expect(page).to have_content "Template was deleted."
		expect(page).to_not have_link workout_template.title
	end
end
