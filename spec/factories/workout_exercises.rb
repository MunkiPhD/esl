# == Schema Information
#
# Table name: workout_exercises
#
#  id          :integer          not null, primary key
#  workout_id  :integer          not null
#  exercise_id :integer          not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout_exercise do
    workout
    exercise

    factory :workout_exercise_with_sets do
      ignore do
        workout_sets_count 3
      end
      after(:build) do |workout_exercise, evaluator|
        workout_sets = FactoryGirl.build_list(:workout_set, 3)
        workout_exercise.workout_sets << workout_sets
      end
    end
  end
end
