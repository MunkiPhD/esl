class API::NutritionGoalsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_goal

	def index
		@nutrition_goals = current_user.nutrition_goal
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
