# == Schema Information
#
# Table name: muscles
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

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
