class API::BodyWeightsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_body_weight, only: [:show, :update]

	def index
		@body_weight = BodyWeight.new(log_date: Date.today)
		@body_weights = current_user.body_weights.latest.includes(:unit)
	end

	def show
		
	end

	def create
		@body_weight = current_user.body_weights.build(body_weight_params)
		@body_weight.unit = current_user.preferences.weight_unit

		if @body_weight.save
			render :show
		else

		end
	end

	def update
		if @body_weight.update(body_weight_params)
			render :show
		else
			# error handling
		end
	end

	private
	def set_body_weight
		@body_weight = current_user.body_weights.find(params[:id])
	end

	def body_weight_params
		params.require(:body_weight).permit(:weight, :log_date, :id)
	end
end
