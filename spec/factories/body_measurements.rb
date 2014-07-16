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
