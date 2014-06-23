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

		factory :workout_template_with_exercises do
			after(:create) do |workout_template, evaluator|
				create_list(:workout_exercise_template_with_sets, 2, workout_template: workout_template)
			end
		end
	end
end
