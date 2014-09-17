class API::NutritionGoalsController < ApplicationController
	before_filter :authenticate_user!

	def index
		selected_date = Date.today
		@presenter = Nutrition::DashboardPresenter.new(current_user, selected_date)
	end
end
