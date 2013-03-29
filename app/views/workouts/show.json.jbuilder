json.(@workout, :id, :title, :date_performed, :notes, :user_id)

# http://railscasts.com/episodes/320-jbuilder?view=asciicast
json.workout_exercises @workout.workout_exercises do |json, workout_exercise|
  json.(workout_exercise, :id, :workout_id, :exercise_id)
  json.workout_sets workout_exercise.workout_sets do |json, workout_set|
    json.(workout_set, :id, :workout_exercise_id, :set_number, :rep_count, :weight, :notes)
  end
end
