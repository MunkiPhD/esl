class MusclesController < ApplicationController
	def index
		@muscles = Muscle.all
	end

	def show
		@muscle = Muscle.find(params[:id])
		@exercises = Exercise.for_muscle(@muscle)
	end
end
