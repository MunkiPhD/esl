# == Schema Information
#
# Table name: nutrition_goals
#
#  id         :integer          not null, primary key
#  calories   :integer          default(0), not null
#  protein    :integer          default(0), not null
#  carbs      :integer          default(0), not null
#  total_fat  :integer          default(0), not null
#  user_id    :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :nutrition_goal do
		calories	275
		protein		10
		carbs			25
		total_fat	15
    user
  end
end
