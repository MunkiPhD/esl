FactoryGirl.define do
	factory :force_type, class: ForceType do
		sequence(:name) { |n| "force_type_#{n}" }
	end
end
