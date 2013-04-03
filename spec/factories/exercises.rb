# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise do
    sequence(:name){ |n| "deadlift_#{n}" }
    user
  end
end
