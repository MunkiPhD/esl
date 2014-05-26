FactoryGirl.define do
	factory :mechanic_type do
		sequence(:name) { |n| "mechanic_type_#{n}" }
	end
end
