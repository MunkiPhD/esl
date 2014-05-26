class ExerciseSearch
	def self.filter(params)
		exercises = Exercise.order(name: :asc)

		exercises = exercises.for_exercise_type(params[:exercise_types]) unless params[:exercise_types].nil?
		exercises = exercises.with_main_muscle(params[:muscles]) unless params[:muscles].nil?
		exercises
	end
end
