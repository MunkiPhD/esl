class API::LogFoodsController < ApplicationController
	before_filter :authenticate_user!


	def create
		@logged_food = current_user.log_foods.build(logged_food_params)

		if @logged_food.save
			render status: :created
		else
			render json: @logged_food.errors, status: :unprocessable_entity
		end
	end

	private
	def logged_food_params
		params.require(:log_food).permit(:servings, :log_date, :food_id)
	end
end
