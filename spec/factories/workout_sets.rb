# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout_set do
    set_number 1
    rep_count 1
    weight 1
    notes "MyString"
    workout nil
    exercise nil
  end
end
