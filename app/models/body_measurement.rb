class BodyMeasurement < ActiveRecord::Base
	include HasMeasurement

	def unit_measurement_type 
		:measurements  
	end

	belongs_to :user
	belongs_to :unit

	validates :user, presence: true
	validates :unit, presence: true

	delegate :unit_abbr, to: :unit, prefix: false
end
