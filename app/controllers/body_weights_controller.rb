class BodyWeightsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@body_weight = BodyWeight.new(log_date: Date.today)
		@body_weights = current_user.body_weights
	end

	def create
		@body_weight = current_user.body_weights.build(body_weight_params)

		respond_to do |format|
			if @body_weight.save
				format.html { redirect_to body_weights_path, notice: "Body Weight entry logged!" }
			else
				format.html { render :index }
			end
		end
	end

	private
	def body_weight_params
		params.require(:body_weight).permit(:weight, :log_date)
	end
end
