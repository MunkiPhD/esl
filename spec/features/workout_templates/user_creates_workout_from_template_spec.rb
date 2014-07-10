require 'rails_helper'

feature 'User logs a workout from a template' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'views the template page and clicks on the log workout button which builds prefilled new workout page with the same title' do
		template = create(:workout_template, user: user)	
		visit workout_template_path(template)

		click_link 'Log Workout'

		expect(page.find('#workout_title').value).to eq template.title

		click_button 'Save Workout'

		expect(page).to have_content template.title
	end

	scenario 'the build workout has the same exercises and sets as the template' do
		template = create(:workout_template_with_exercises, user: user)
		visit workout_template_path(template)

		click_link 'Log Workout'

		template.workout_exercise_templates.each do |we|
			expect(page).to have_content we.exercise_name
		end
	end

	scenario 'if a template has a one rep max exercise set, it gets the ORM for that exercise (for the user) and sets it as the weight for that set' do
		orm_percent = 60
		workout_template = create(:workout_template, user: user)
		exercise = create(:exercise)
		workout_exercise_template = create(:workout_exercise_template, workout_template: workout_template, exercise: exercise)
		workout_set_template = create(:workout_set_template, exercise: exercise, workout_exercise_template: workout_exercise_template, workout_template: workout_template, is_percent_of_one_rep_max: true, percent_of_one_rep_max: orm_percent)


		workout = create(:workout, user: user)
		workout_set = create(:workout_set, exercise: exercise, workout: workout)

		visit workout_template_path(workout_template)
		expect(page).to have_content exercise.name

		click_link 'Log Workout'

		last_nested_exercise = all(".workouts_workout_exercise").last

		within(last_nested_exercise) do
			expected_weight = (orm_percent.to_f / 100).to_f * workout_set.weight.to_f
			expect(find("#workout_workout_exercises_attributes_0_workout_sets_attributes_0_weight").value).to eq expected_weight.to_s
		end
	end

	scenario 'if a set has an ORM, but the user has not logged that exercise, it sets the weight as zero and displays a mesasge that no ORM was available' do
		workout_template = create(:workout_template, user: user)
		exercise = create(:exercise)
		workout_exercise_template = create(:workout_exercise_template, workout_template: workout_template, exercise: exercise)
		workout_set_template = create(:workout_set_template, exercise: exercise, workout_exercise_template: workout_exercise_template, workout_template: workout_template, is_percent_of_one_rep_max: true, percent_of_one_rep_max: 60)

		visit workout_template_path(workout_template)
		expect(page).to have_content exercise.name

		click_link 'Log Workout'

		last_nested_exercise = all(".workouts_workout_exercise").last

		within(last_nested_exercise) do
			expect(find("#workout_workout_exercises_attributes_0_workout_sets_attributes_0_weight").value).to eq "0.0"
		end
	end
end
