# == Schema Information
#
# Table name: body_weights
#
#  id         :integer          not null, primary key
#  log_date   :date             default(Thu, 29 May 2014), not null
#  weight     :decimal(9, 6)    not null
#  unit_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

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
