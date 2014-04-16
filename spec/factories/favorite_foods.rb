# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite_food do
    user
    food
  end
end
