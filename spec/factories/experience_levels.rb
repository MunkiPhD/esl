# == Schema Information
#
# Table name: experience_levels
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
	factory :experience_level do
		sequence(:name) { |n| "experience_level_#{n}" }
	end
end
