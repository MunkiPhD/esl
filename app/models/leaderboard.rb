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


  # gets the latest workout for the users in the circle with the higheset weight for the specified exercise
  # e.g. for Deadlifts for circle "Lifters of the Dead"
  #   Mark
  #     workout1: 400 lbs
  #     workout2: 350 lbs
  #
  #   Steve
  #     workout3: 380 lbs
  #     workout4: 550 lbs
  #
  #   The result set would be [workout4, workout1]
  #
  def self.max_weight_for_exercise_on_circle(circle, exercise)
    unless circle.members.blank?
      circle_member_workouts(circle).max_weight(exercise)
    else
      []
    end
  end
end
