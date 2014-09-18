class API::NutritionGoalsController < ApplicationController
	before_filter :authenticate_user!

	def index
		selected_date = Date.today
		@presenter = Nutrition::DashboardPresenter.new(current_user, selected_date)
	end
=begin
  def selected_date
    d = Date.new(date_params[:year].to_i, date_params[:month].to_i, date_params[:day].to_i) rescue nil
    if d
      return d
    else
      return Date.today
    end
  end
=end
end
