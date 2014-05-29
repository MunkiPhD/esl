# == Schema Information
#
# Table name: force_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
	factory :force_type, class: ForceType do
		sequence(:name) { |n| "force_type_#{n}" }
	end
end
