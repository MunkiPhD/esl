# == Schema Information
#
# Table name: workout_exercise_templates
#
#  id                  :integer          not null, primary key
#  workout_template_id :integer          not null
#  exercise_id         :integer          not null
#

FactoryGirl.define do
	factory :workout_exercise_template do
		workout_template
		exercise
	end

	factory :workout_exercise_template_for_build, class: WorkoutExerciseTemplate do
		#workout_template
		exercise

		after(:build) do |workout_exercise_template|
			for i in 0..1 do
				wst1 = build(:workout_set_template_for_build, workout_exercise_template: workout_exercise_template, workout_template: workout_exercise_template.workout_template)
				workout_exercise_template.workout_set_templates << wst1
			end
		end
	end
end
