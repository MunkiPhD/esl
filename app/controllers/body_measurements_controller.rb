class BodyMeasurementsController < ApplicationController
	def index
	end

	def new
		@body_measurement = BodyMeasurement.new
	end
end
