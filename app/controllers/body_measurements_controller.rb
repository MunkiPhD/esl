class BodyMeasurementsController < ApplicationController
	before_filter :set_body_measurement, only: [:show, :edit, :update]

	def index
		@body_measurements = current_user.body_measurements.select(:log_date, :id, :user_id)
	end

	def show
	end

	def new
		@body_measurement = current_user.body_measurements.build
	end

	def create
		@body_measurement = current_user.body_measurements.build(body_measurement_params)

		respond_to do |format|
			if @body_measurement.save
				flash[:success] = "Body measurements saved."
				format.html { redirect_to @body_measurement }
			else
				format.html { render :new }
			end
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @body_measurement.update(body_measurement_params)
				flash[:success] = "Body measurements entry was updated."
				format.html { redirect_to @body_measurement }
			else
				format.html { render :edit }
			end
		end
	end

	private

	def set_body_measurement
		@body_measurement = current_user.body_measurements.find(params[:id])
	end

	def body_measurement_params
		params.require(:body_measurement).permit(:log_date,
																:bicep,
																:calf, 
																:chest,
																:forearm,
																:hips,
																:neck,
																:thigh,
																:waist)
	end
end
