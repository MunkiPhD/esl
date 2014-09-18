class API::NutritionGoalsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@presenter = Nutrition::DashboardPresenter.new(current_user, selected_date)
	end

	private
	def selected_date
		d = Date.new(date_params[:year].to_i, date_params[:month].to_i, date_params[:day].to_i) rescue nil
		if d
			return d
		else
			return Date.today
		end
	end

	def date_params
		params.require(:log_date)
	end
end
