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

  def self.max_weight_for_exercise_on_circle(circle, exercise)
    unless circle.members.blank?
=begin
      selected_fields = <<-SELECT
        workouts.id AS workout_id, 
        workout_sets.weight AS weight,
        workout_sets.id AS workout_set_id,
        workout_exercises.id AS exercise_id,
        ROW_NUMBER() OVER (
           PARTITION BY workouts.user_id 
           ORDER BY workout_sets.weight DESC, workouts.id DESC) as row_num
      SELECT

      .joins(", (#{Workout.joins(:workout_exercises => :workout_sets).select(selected_fields).to_sql}) as t")
              .select("workouts.*, t.*")
              .where("workouts.id = t.workout_id AND t.row_num = 1") # AND workouts.user_id IN (#{resource_ids.join(",")})")
              .order("t.weight DESC")
=end

      circle_member_workouts(circle).max_weight(exercise)

    else
      []
    end
  end
end
