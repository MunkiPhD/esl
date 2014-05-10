module HasMeasurement
	extend ActiveSupport::Concern

	included do
		before_validation :set_unit_for_model
	end


	def set_unit_for_model
		type_value = Unit.unit_types[self.unit_measurement_type]
		self.unit = Unit.for_system(MeasurementSystem::US_SYSTEM).for_unit(type_value).first
	end
end
