class WorkoutTemplatesController < ApplicationController
	before_action :set_workout, only: [:new]	

	def new
		@exercises = Exercise.all
	end

	private
		def set_workout
			@workout = Workout.find(params[:id])
		end
end
