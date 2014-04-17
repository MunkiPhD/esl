# == Schema Information
#
# Table name: favorite_foods
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  food_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite_food do
    user
    food
  end
end
