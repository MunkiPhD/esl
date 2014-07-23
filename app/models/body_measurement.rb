# == Schema Information
#
# Table name: body_measurements
#
#  id         :integer          not null, primary key
#  log_date   :date             default(Wed, 16 Jul 2014), not null
#  bicep      :decimal(5, 2)
#  calf       :decimal(5, 2)
#  chest      :decimal(5, 2)
#  forearm    :decimal(5, 2)
#  hips       :decimal(5, 2)
#  neck       :decimal(5, 2)
#  thigh      :decimal(5, 2)
#  waist      :decimal(5, 2)
#  unit_id    :integer          default(0), not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class BodyMeasurement < ActiveRecord::Base
	include HasMeasurement
	after_initialize :set_unit

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

	private

	def set_unit
		unless self.user.nil?
			self.unit = Unit.for_unit_system(self.user.preferences.default_system_id).for_unit_type(self.unit_measurement_type).first
		else
			self.unit = Unit.for_system(:us_system).for_unit_type(self.unit_measurement_type).first
		end
	end
end
