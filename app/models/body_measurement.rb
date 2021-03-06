# == Schema Information
#
# Table name: body_measurements
#
#  id            :integer          not null, primary key
#  log_date      :date             default(Wed, 16 Jul 2014), not null
#  bicep_right   :decimal(5, 2)
#  calf_right    :decimal(5, 2)
#  chest         :decimal(5, 2)
#  forearm_right :decimal(5, 2)
#  hips          :decimal(5, 2)
#  neck          :decimal(5, 2)
#  thigh_right   :decimal(5, 2)
#  waist         :decimal(5, 2)
#  unit_id       :integer          default(0), not null
#  user_id       :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#  bicep_left    :decimal(5, 2)
#  calf_left     :decimal(5, 2)
#  forearm_left  :decimal(5, 2)
#  thigh_left    :decimal(5, 2)
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

	validates :bicep_left, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :bicep_right, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :calf_left, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :calf_right, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :chest, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :forearm_left, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :forearm_right, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :hips, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :neck, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :thigh_left, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :thigh_right, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 
	validates :waist, numericality: { only_integer: false, greater_than: 0, less_than: 100, allow_nil: true } 

	delegate :unit_abbr, to: :unit, prefix: false

	scope :latest, -> { order(log_date: :desc) }

	self.per_page = 3

	private

	def set_unit
		unless self.user.nil?
			if self.unit.nil?
				self.unit = Unit.for_unit_system(self.user.preferences.default_system_id).for_unit_type(self.unit_measurement_type).first
			end
		else
			self.unit = Unit.for_system(:us_system).for_unit_type(self.unit_measurement_type).first
		end
	end
end
