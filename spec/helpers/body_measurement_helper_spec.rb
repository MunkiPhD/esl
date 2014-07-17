require 'rails_helper'

describe BodyMeasurementHelper do
	describe '#measurement_display' do
		it "shows 'not measured' if entry is blank" do
			body_measurement = BodyMeasurement.new(chest: nil)
			result = helper.measurement_display(body_measurement, :chest)
			expect(result).to eq "Chest: not measured"
		end

		it 'shows the value of the entry with the correct unit' do
			body_measurement = build(:body_measurement, chest: 52)
			result = helper.measurement_display(body_measurement, :chest)
			expect(result).to eq "Chest: 52.0 in"
		end
	end
end
