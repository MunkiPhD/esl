class Leaderboard
  # gets the workouts for all the members in the circle
  def self.circle_member_workouts(circle)
    unless circle.members.blank?
      resource_ids = circle.members.pluck(:user_id)
      Workout.where(user_id: resource_ids)
    else
      [] #return an empty array if members is blank
    end
  end
end
