module Nutrition
	class DashboardPresenter
		def initialize(user, selected_date)
			@user = user
			@selected_date = selected_date
		end

		def current_date 
			@selected_date
		end

		def logged_foods
			@logged_foods ||= @user.log_foods.on_date(current_date).latest
		end

		def nutrition_goal
			@nutrition_goal = (@user.nutrition_goal ||= NutritionGoal.where(user: @user).first_or_create)
		end

		def macro_totals
			@macro_totals ||= DailyNutritionTotals.sum_totals(logged_foods)
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
	end # end DashboardPresenter
end # end Nutrition
