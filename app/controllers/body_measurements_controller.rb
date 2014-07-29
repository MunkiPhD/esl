class BodyMeasurementsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_body_measurement, only: [:show, :edit, :update, :destroy]

	def index
		@body_measurement = current_user.body_measurements.build(log_date: Date.today)
		@body_measurements = current_user.body_measurements.latest.select(:log_date, :id, :user_id, :unit_id)
	end

	def show
	end

	def new
		@body_measurement = current_user.body_measurements.build(log_date: Date.today)
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

	def destroy
		respond_to do |format|
			if @body_measurement.destroy
				flash[:success] = "Body measurement entry was deleted."
				format.html { redirect_to body_measurements_path }
			else
				flash[:error] = "Failed to delete the body measurement entry"
				format.html { redirect_to @body_measurement }
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
