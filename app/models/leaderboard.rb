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
      resource_ids = circle.members.pluck(:user_id)
      #Workout.max_weight.where("exercise_id =? AND workouts.user_id IN (?)", exercise.id, resource_ids.join(","))
      Workout.find_by_sql("
        WITH joined_table AS (
          SELECT workout_sets.weight AS weight, 
            workouts.user_id AS user_id, 
            workouts.id AS workout_id, 
        		workout_sets.id AS workout_set_id,
        		workout_exercises.exercise_id AS exercise_id
        	FROM workouts 
        	INNER JOIN workout_exercises ON workout_exercises.workout_id = workouts.id 
        	INNER JOIN workout_sets ON workout_sets.workout_exercise_id = workout_exercises.id       
        	ORDER BY workout_sets.weight DESC
        	),
        
        result_set AS (
        	SELECT MAX(x.workout_id) AS workout_id, x.user_id, x.weight, x.workout_set_id, x.exercise_id
        	FROM joined_table x
          JOIN (SELECT p.user_id, MAX(weight) as weight
        		FROM joined_table p
        		GROUP BY p.user_id) y 
        	ON y.user_id = x.user_id AND y.weight = x.weight
        	GROUP BY x.user_id, x.weight, x.workout_set_id, x.exercise_id
        	ORDER BY x.weight DESC)
        
        SELECT workouts.*, result_set.weight, result_set.workout_set_id, result_set.exercise_id
        FROM workouts, result_set
        WHERE workouts.id = result_set.workout_id 
        	AND result_set.exercise_id = #{exercise.id} 
        	AND workouts.user_id IN (#{resource_ids.join(",")})")
    else
      []
    end
  end
=begin

=end
end
