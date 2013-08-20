# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :food do
    name "Chicken Breast"
  end

  factory :ice_cream do
    name "Chocolate Trinity"
    brand "Publix"
    calories "160"
    carbs "25"
    protein "3"
  end

  factory :bread do
    name "100% Wheat Bread"
    brand "Wonder"
    calories "110"
    carbs "15"
  end
end
