class NutritionController < ApplicationController
  before_filter :authenticate_user!

  def index
    @current_date = selected_date 
    @logged_foods = current_user.log_foods.on_date(@current_date).latest
	 @nutrition_goal = (current_user.nutrition_goal ||= NutritionGoal.where(user: current_user).first_or_create)
	 @macro_totals = DailyNutritionTotals.sum_totals(@logged_foods)
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
