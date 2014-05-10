require 'spec_helper'

describe BodyWeight do
	let(:user) { create(:user) }
	let(:body_weight) { build(:body_weight, user: user) }

	it 'has a valid factory' do
		expect(body_weight).to be_valid	
	end

	describe 'validations' do
		it 'has a weight greater than 0' do
			expect(BodyWeight.new).to have(2).errors_on(:weight)
		end

		it 'has a user' do
			expect(BodyWeight.new).to have(1).error_on(:user)
		end

		it 'has a unit' do
			expect(BodyWeight.new).to have(0).error_on(:unit)
		end
	end

	it 'on save, it sets the unit' do
		instance  = user.body_weights.build(weight: 100)
		puts "inside test, unit: #{instance.unit}"
		expect(instance).to be_valid
		instance.save
		expect(instance.unit.unit_system_name).to eq "US"
		expect(instance.unit.unit_type_name).to eq "weight"
	end
end
