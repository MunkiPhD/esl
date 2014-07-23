# == Schema Information
#
# Table name: user_preferences
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  default_system_id :integer          default(0), not null
#  created_at        :datetime
#  updated_at        :datetime
#

FactoryGirl.define do
	factory :user_preferences do
		user
		default_system_id		0
	end

	factory :user_preferences_metric, class: UserPreferences do
		user
		default_system_id		1
	end
end
