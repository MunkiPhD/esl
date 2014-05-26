FactoryGirl.define do
	factory :equipment do
		sequence(:name) { |n| "barbell_#{n}" }
	end
end
