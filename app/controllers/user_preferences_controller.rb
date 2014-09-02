class UserPreferencesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_preferences, only: [:edit, :update]

	def edit
	end

	def update
		respond_to do |format|
			@preferences.default_system_id = params[:default_unit_system]
			if @preferences.update(user_preferences_params)
				flash[:success] = "Unit system updated"
				format.html { redirect_to athlete_path(current_user) }
			end
		end
	end

	private
		def set_preferences
			@preferences = UserPreferences.find_or_create_by(user: current_user)
		end

		def user_preferences_params
			params.permit(:default_system_id)
		end
end
