class BodyMeasurementsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_body_measurement, only: [:show, :edit, :update, :destroy]

	def index
		@body_measurement = current_user.body_measurements.build(log_date: Date.today)
		# will_paginate doesn't like it when you use selects. This can obviously be optimized, but we will leave it as is for now
		@body_measurements = current_user.body_measurements.latest.paginate(page: params[:page], per_page: 15) #.select(:log_date, :id, :user_id, :unit_id)
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
		params.permit(:page)
		params.require(:body_measurement).permit(:log_date,
																:bicep_left,
																:bicep_right,
																:calf_left, 
																:calf_right, 
																:chest,
																:forearm_left,
																:forearm_right,
																:hips,
																:neck,
																:thigh_left,
																:thigh_right,
																:waist)
	end
end
