module WorkoutQueries
	def self.max_weight_for_exercise_and_user(exercise, user)
			user.workout_sets.joins(:workout)
			.for_exercise(exercise)
			.by_weight_desc
			.select("workout_sets.weight AS weight, 
													 workout_sets.id AS workout_set_id, 
													 workout_sets.rep_count AS rep_count, 
													 workouts.id AS id,
													 workouts.title AS title,
													 workouts.user_id AS user_id, 
													 workouts.date_performed AS date_performed")
	end
end
