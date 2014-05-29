# == Schema Information
#
# Table name: exercise_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
	factory :exercise_type do
		sequence(:name) { |n| "powerlifting_#{n}" }
	end
end
