# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle do
    sequence(:name) { |n| "Tampa Powerlifting#{n}" }
    motto           "Lift Heavy."
    description     "Train hard, compete"
    is_public       true
    user
  end
end
