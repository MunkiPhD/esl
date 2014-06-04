class UserPreferencesController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_preferences, only: [:show, :edit]

	def show
	end

	def edit
	end

	private

		def set_preferences
			@preferences = UserPreferences.find_or_create_by(user: current_user)
		end
end
