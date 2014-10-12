class API::BodyWeightsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@body_weight = BodyWeight.new(log_date: Date.today)
		@body_weights = current_user.body_weights.latest.includes(:unit)
	end

	def create
		render :show
	end
end
