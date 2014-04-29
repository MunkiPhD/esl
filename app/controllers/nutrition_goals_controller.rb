class NutritionGoalsController < ApplicationController
	before_filter :set_goal, only: [:edit]

	def edit
	end

	private
	def set_goal
		@nutrition_goal = current_user.nutrition_goal
		if @nutrition_goal.blank?
			NutritionGoal.new(user: current_user).save
		end
		@nutrition_goal = current_user.nutrition_goal
	end
end
