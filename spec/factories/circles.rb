# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle do
    name            "Tampa Powerlifting"
    motto           "Lift Heavy."
    description     "Train hard, compete"
    is_public          true
    user
  end
end
