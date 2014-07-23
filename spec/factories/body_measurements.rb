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

FactoryGirl.define do
	factory :body_measurement do
		user
		association :unit, factory: :unit_measurements
		log_date	"2014-03-24"
		bicep		16.2
		calf		17.1
		chest		52.52
		forearm	13.2
		hips		38.2
		neck		12.1
		thigh		24.2
		waist		34
	end
end
