FactoryGirl.define do
	factory :experience_level do
		sequence(:name) { |n| "experience_level_#{n}" }
	end
end
