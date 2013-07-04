json.array!(@workouts) do |workout|
  json.extract! workout, :id, :title, :date_performed, :notes, :user_id
  #json.url workout_url(workout, format: :json)
end
