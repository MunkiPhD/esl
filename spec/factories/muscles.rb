FactoryGirl.define do
	factory :muscle do
		sequence(:name) { |n|	"muscle_#{n}" }
	end

	factory :lats do
		name 'Lats'
	end

	factory :hamstrings do
		name 'Hamstrings'
	end
end
