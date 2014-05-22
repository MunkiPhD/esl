FactoryGirl.define do
	factory :exercise_type do
		sequence(:name) { |n| "powerlifting_#{n}" }
	end
end
