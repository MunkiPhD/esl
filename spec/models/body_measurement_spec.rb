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

require 'rails_helper'

RSpec.describe BodyMeasurement, :type => :model do
	let(:user) { create(:user) }

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

		it 'is unique per day per user' do
			Timecop.freeze(Date.today) do
				bm1 = create(:body_measurement, user: user, log_date: Date.today)
				bm2 = build(:body_measurement, user: user, log_date: Date.today)
				bm2.valid?
				puts bm2.errors
				expect(bm2.errors[:log_date]).to include "an entry for this date already exists"
			end
		end

		it 'can have entries for the same day for different users' do
			Timecop.freeze(Date.today) do
				bm1 = create(:body_measurement, user: user, log_date: Date.today)
				bm2 = create(:body_measurement, user: create(:user), log_date: Date.today)
				expect(bm2.valid?).to eq true
			end
		end

		%w(bicep calf chest forearm hips neck thigh waist).each do |attr|
			describe "#{attr}" do
				it 'can be null' do
					is_null(attr)
				end

				it 'must be greater than zero' do
					is_greater_than_zero(attr)
				end

				it 'is less than 100' do
					is_less_than_100(attr)
				end

			end
		end
	end

	describe '.latest' do
		it 'returns the entries with the latest first by log date' do
			Timecop.freeze(Date.today) do
			user = create(:user)
			measurement_latest = create(:body_measurement, log_date: Date.today, user: user)
			measurement_earliest = create(:body_measurement, log_date: 3.days.ago, user: user)

			expect(BodyMeasurement.latest).to eq [measurement_latest, measurement_earliest]
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

def is_greater_than_zero(symbol)
	bm = BodyMeasurement.new
	bm[symbol] = -1
	bm.valid?
	expect(bm.errors[symbol]).to include "must be greater than 0"
end

def is_less_than_100(symbol)
	bm = BodyMeasurement.new
	bm[symbol] = 101
	bm.valid?
	expect(bm.errors[symbol]).to include "must be less than 100"
end

def is_null(symbol)
	body_measurement = BodyMeasurement.new
	body_measurement[symbol] = nil
	body_measurement.valid?
	expect(body_measurement.errors[symbol]).to eq []
end 
