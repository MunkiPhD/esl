# == Schema Information
#
# Table name: workout_templates
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  notes      :text             default(""), not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
	factory :workout_template do
		sequence(:title)	{ |n| "test_#{n}" }
		notes							"some random notes!"
		user

	end

	factory :workout_template_with_exercises, class: WorkoutTemplate do
		sequence(:title)	{ |n| "test_#{n}" }
		notes							"some random notes!"
		user

		after(:build) do |workout_template|
			for i in 0..1 do
				wet1 = build(:workout_exercise_template_for_build, workout_template: workout_template)
				workout_template.workout_exercise_templates << wet1
			end
		end
	end
end
