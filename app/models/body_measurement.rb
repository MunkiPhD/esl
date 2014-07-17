class BodyMeasurement < ActiveRecord::Base
	include HasMeasurement

	def unit_measurement_type 
		:measurements  
	end

	belongs_to :user
	belongs_to :unit

	validates :user, presence: true
	validates :unit, presence: true

	validates :log_date, presence: true, uniqueness: { scope: :user, message: "an entry for this date already exists" }

	validates :bicep, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :calf, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :chest, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :forearm, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :hips, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :neck, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :thigh, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :waist, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 

	delegate :unit_abbr, to: :unit, prefix: false
end
