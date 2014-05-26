class MechanicTypesController < ApplicationController
	def show
		@mechanic_type = MechanicType.find(params[:id])
		@exercises = Exercise.for_mechanic_type(@mechanic_type)
	end
end
