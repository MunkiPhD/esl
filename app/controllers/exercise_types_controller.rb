class ExerciseTypesController < ApplicationController
	def show
		@exercise_type = ExerciseType.find(params[:id])
		@exercises = Exercise.for_exercise_type(@exercise_type)
	end
end
