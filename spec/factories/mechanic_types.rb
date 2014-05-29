# == Schema Information
#
# Table name: mechanic_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
	factory :mechanic_type do
		sequence(:name) { |n| "mechanic_type_#{n}" }
	end
end
