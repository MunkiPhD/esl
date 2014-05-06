module WorkoutsHelper
  def workout_index_title(user)
    if user.username == current_user.username
      "My Workouts"
    else
      "#{user.username}'s Workouts"
    end
  end
 end
