class EquipmentsController < ApplicationController
	def show
		@equipment = Equipment.find(params[:id])
		@exercises = Exercise.for_equipment(@equipment)
	end
end
