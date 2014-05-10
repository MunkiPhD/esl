module HasMeasurement
	extend ActiveSupport::Concern

	included do
		before_validation :set_unit_for_model
	end


	def set_unit_for_model
		self.unit = Unit.for_system(:us_system).for_unit_type(self.unit_measurement_type).first
	end
end
