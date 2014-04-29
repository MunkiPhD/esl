class NutritionGoalsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_goal, only: [:edit, :update]

	def edit
	end

	def update
		if @nutrition_goal.update_attributes(nutrition_goal_params)
			flash[:success] = "Daily nutrition goals have been updated."
			redirect_to nutrition_path
		else
			render :edit
		end
	end

	private
	def set_goal
		@nutrition_goal = current_user.nutrition_goal
		if @nutrition_goal.blank?
			NutritionGoal.new(user: current_user).save
		end
		@nutrition_goal = current_user.nutrition_goal
	end

	def nutrition_goal_params
		params.require(:nutrition_goal).permit(:calories, :protein, :carbs, :total_fat)
	end
end
