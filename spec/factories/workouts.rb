# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout do
    title           "Deadlift - Reps"
    date_performed  "2013-03-11"
    notes           "Felt great to have cold steel in my hands"
    user

    factory :invalid_workout do
      title           nil
    end
  end
end
