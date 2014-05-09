# == Schema Information
#
# Table name: nutrition_goals
#
#  id         :integer          not null, primary key
#  calories   :integer          default(2000), not null
#  protein    :integer          default(50), not null
#  carbs      :integer          default(300), not null
#  total_fat  :integer          default(65), not null
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
