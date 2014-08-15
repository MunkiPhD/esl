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

FactoryGirl.define do
	factory :body_measurement do
		user
		association :unit, factory: :unit_measurements
		log_date	"2014-03-24"
		bicep_left		16.0
		bicep_right		16.1
		calf_left		17.0
		calf_right		17.1
		chest				52.52
		forearm_left	13.0
		forearm_right	13.1
		hips				38.2
		neck				12.1
		thigh_left		24.0
		thigh_right		24.1
		waist				34
	end
end
