# == Schema Information
#
# Table name: body_weights
#
#  id         :integer          not null, primary key
#  log_date   :date             default(Thu, 22 May 2014), not null
#  weight     :decimal(9, 6)    not null
#  unit_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
	factory :body_weight do
		weight		182.4531
		log_date		"2013-04-13"
		user	
		unit
	end
end
