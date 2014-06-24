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
		after(:build) do |workout_template|
			build_list(:workout_exercise_template, 1, workout_template: workout_template)
		end
	end
end
