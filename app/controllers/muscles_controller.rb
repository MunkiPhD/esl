class MusclesController < ApplicationController
	def index
		@muscles = Muscle.all
	end

	def show
		@muscle = Muscle.find(params[:id])
		@exercises = Exercise.with_main_muscle(@muscle)
	end
end
