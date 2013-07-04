# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout do
    title           "Deadlift - Reps"
    date_performed  "2013-03-11"
    notes           "Steel feels great between my hands"
    user

    factory :invalid_workout do
      title           nil
    end

    factory :workout_with_exercises do
      ignore do
        workout_exercises_count 2
      end

      after(:build) do |workout, evaluator|
        workout_exercises = FactoryGirl.build(:workout_exercise_with_sets)
        workout.workout_exercises << workout_exercises
        #FactoryGirl.build_list(:workout_exercise, evaluator.workout_exercises_count, workout: workout)
      end
    end
  end
end
