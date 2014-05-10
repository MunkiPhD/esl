class BodyWeight < ActiveRecord::Base
	include HasMeasurement

	def unit_measurement_type 
	  	:weight  
	end


	belongs_to :user
	belongs_to :unit

	validates :weight, presence: true, numericality: {	only_integer: false,	greater_than: 0, less_than: 900 }
	validates :user, presence: true
	validates :unit, presence: true
end
