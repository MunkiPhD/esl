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
		#workout_template
		exercise

			after(:build) do |workout_exercise_template|
				create_list(:workout_set_template, 2, workout_exercise_template: workout_exercise_template, workout_template: workout_exercise_template.workout_template)
			end

	end
end
