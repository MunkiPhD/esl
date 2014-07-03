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
      fill_in "workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_weight", with: "225"
			check	"workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_is_percent_of_one_rep_max"
			fill_in "workout_template_workout_exercise_templates_attributes_0_workout_set_templates_attributes_0_percent_of_one_rep_max", with: "85"
    end

    expect {
      click_button "Save Workout"
    }.to change(WorkoutTemplate, :count).by(1)

    expect(page).to have_link template.title
	end
end
