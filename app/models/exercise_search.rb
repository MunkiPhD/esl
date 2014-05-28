class ExerciseSearch
	def self.filter(params)
		exercises = Exercise.order(name: :asc)

		exercises = exercises.for_exercise_type(params[:exercise_types]) unless params[:exercise_types].nil?
		exercises = exercises.for_muscle(params[:muscles]) unless params[:muscles].nil?
		exercises = exercises.for_equipment(params[:equipments]) unless params[:equipments].nil?
		exercises = exercises.for_force_type(params[:force_types]) unless params[:force_types].nil?
		exercises = exercises.for_experience_level(params[:experience_levels]) unless params[:experience_levels].nil?
		exercises
	end
end
