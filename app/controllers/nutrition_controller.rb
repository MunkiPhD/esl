class NutritionController < ApplicationController
	before_filter :authenticate_user!

	def index
		@presenter = Nutrition::DashboardPresenter.new(current_user, selected_date)
		save_date_to_session selected_date
	end


	private
	def selected_date
		d = Date.new(date_params[:year].to_i, date_params[:month].to_i, date_params[:day].to_i) rescue nil
		if d
			return d
		else
			return session_date
		end
	end

	def save_date_to_session(date)
		session[:nutrition_date] = date
	end

	def session_date
      #selected_date = session[:nutrition_date] #if the date from the parameters is null, get the one from the session
      #if selected_date.nil?
      #  selected_date = Date.today # if it's null, do today
		#end
		session[:nutrition_date].blank? ? Date.today : session[:nutrition_date]
	end

	def date_params
		params.require(:log_date)
	end
end
