require 'rails_helper'

RSpec.describe BodyMeasurement, :type => :model do
	it 'has a valid factory' do
		expect(build(:body_measurement)).to be_valid
	end

	describe 'validations' do
		it 'must have a user' do
			bm = BodyMeasurement.new(user: nil)
			bm.valid?
			expect(bm.errors[:user]).to include "can't be blank"
		end

		it 'has a unit by default' do
			bm = BodyMeasurement.new
			bm.valid?
			expect(bm.errors[:unit]).to eq []
		end

		#%w(:bicep :calf :chest :forearm :hips :neck :thigh :waist).each do |attr|
		describe "bicep" do
			it "can be null" do
				is_not_null(:bicep)
			end
		end
	end

	describe '#unit_abbr' do
		it 'returns the unit abbreviation for the unit' do
			bm = build(:body_measurement)
			expect(bm.unit_abbr).to eq 'in'
		end
	end
end

def is_not_null(symbol)
	body_measurement = BodyMeasurement.new
	body_measurement[symbol] = nil
	expect(body_measurement.errors[symbol]).to include "can't be blank"
end 
