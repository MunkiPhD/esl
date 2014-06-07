module HasMeasurement
	extend ActiveSupport::Concern

	included do
		before_validation :set_unit_for_model
	end


	def set_unit_for_model
		unless self.user.nil?
			self.unit = Unit.for_unit_system(self.user.preferences.default_system_id).for_unit_type(self.unit_measurement_type).first
		else
			self.unit = Unit.for_system(:us_system).for_unit_type(self.unit_measurement_type).first
		end
	end
end
