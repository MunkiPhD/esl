json.array!(@exercises) do |exercise|
  json.extract! exercise, :name, :user
  json.url exercise_url(exercise, format: :json)
end
