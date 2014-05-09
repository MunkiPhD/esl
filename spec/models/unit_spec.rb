# == Schema Information
#
# Table name: units
#
#  id               :integer          not null, primary key
#  unit_type        :integer          not null
#  unit_type_name   :string(255)      not null
#  unit_system      :integer          not null
#  unit_system_name :string(255)      not null
#  unit_name        :string(255)      not null
#  unit_abbr        :string(255)      not null
#

require 'spec_helper'

describe Unit do
	it 'cannot be validated' do
		expect { Unit.new().valid?	}.to raise_error
	end

	it 'cannot be saved' do
		expect { Unit.new().save }.to raise_error
	end

	it 'returns correct unit name' do
		unit = Unit.weight.us_system.first
		expect(unit.unit_type_name).to eq "weight"
	end

	context 'us system' do
		let(:unit) { Unit.us_system }

		it 'has us for system' do
			expect(unit.first.unit_system_name).to eq "US"
		end
	end

	describe '.for_system' do
		it 'gets US system measurement' do
			unit = Unit.for_system(MeasurementSystem::US_SYSTEM).first
			expect(unit.unit_system_name).to eq "US"
		end

		it 'gets metric system measurement' do
			unit = Unit.for_system(MeasurementSystem::METRIC_SYSTEM).first
			expect(unit.unit_system_name).to eq "METRIC"
		end
	end

	context 'metric system' do
		let(:unit) { Unit.metric_system }

		it 'has metric for system' do
			expect(unit.first.unit_system_name).to eq "METRIC"
		end
	end
end
