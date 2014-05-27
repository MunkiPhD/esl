class ForceTypesController < ApplicationController
	def show
		@force_type = ForceType.find(params[:id])
		@exercises = Exercise.for_force_type(@force_type)
	end
end
