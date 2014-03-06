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
    if circle.members.blank?
      return []
    end

=begin
    circle_member_ids = circle.members.pluck(:user_id)
    Workout.find_by_sql("SELECT *
                       FROM workouts INNER JOIN workout_sets ON workouts.id = workout_sets.workout_id
                      WHERE exercise_id = :exercise_id AND workouts.user_id IN (:circle_members)
                        ",{exercise_id: exercise.id, circle_members: circle_member_ids.to_a})

    Workout.joins(:workout_sets).where(user_id: circle_member_ids).group(:workout_id, :exercise_id).having("workout_sets.exercise_id = ?", exercise.id).maximum("workout_sets.weight") #find_by_sql("DISTINCT workout_set.workout_id as 'workout_id'
=end
    #Workout.joins(:workout_sets).select("DISTINCT(workouts.user_id, workouts.id), workout_sets.weight, workouts.*").for_exercise(exercise).order("workout_sets.weight DESC").where(user_id: circle_member_ids)

   ##### circle_member_workouts(circle).max_weight(exercise)

=begin
#
# This is the query we want to work off of
#
SELECT workoutjoin.user_id, workoutjoin.workout_id, MAX(workoutjoin.weight) as weight
FROM (
  SELECT workouts.id as workout_id, workouts.user_id as user_id, workout_sets.weight as weight
  FROM workouts INNER JOIN workouts_sets ON workouts.id = workout_sets.workout_id
  WHERE workout_sets.exercise_id = 1) as workoutjoin
GROUP BY workoutjoin.user_id, workoutjoin.workout_id



select workouts.*, groupeduser.weight
from workouts
inner join
  (SELECT workoutjoin.user_id, MAX(workoutjoin.weight) as weight
    FROM (
      SELECT workouts.user_id as user_id, workout_sets.weight as weight
      FROM workouts INNER JOIN workout_sets ON workouts.id = workout_sets.workout_id
      WHERE workout_sets.exercise_id = 1) as workoutjoin
  GROUP BY workoutjoin.user_id) as groupeduser
  ON workouts.user_id = groupeduser.user_id
  INNER JOIN workout_sets
  ON groupeduser.weight = workout_sets.weight AND workout_sets.workout_id = workouts.id
=end

    circle_member_ids = circle.members.pluck(:user_id)
    sql_statement = Workout.select("workouts.id as workout_id, workouts.user_id as user_id, workout_sets.weight as weight")
      .joins(:workout_sets)
      .for_exercise(exercise)
      .where(user_id: circle_member_ids).to_sql

    workouts = Workout.select("workoutjoin.workout_id as id, workoutjoin.user_id as user_id, MAX(workoutjoin.weight) as weight")
      .from("( #{sql_statement} ) as workoutjoin")
      .group(["workoutjoin.workout_id", "workoutjoin.user_id"])

    workout_ids = workouts.pluck("workout_id")
    Workout.where(id: workout_ids) #"workouts.id Iid: workout_ids)

  end
end
