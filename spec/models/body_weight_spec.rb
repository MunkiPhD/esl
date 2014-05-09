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
			expect(BodyWeight.new).to have(1).error_on(:unit)
		end
	end

	it 'on save, it sets the unit' do
		body_weight.save
		instance  = user.body_weights.create(weight: 100)
		unit = Unit.us_system.weight.first
		expect(instance.unit.unit_system).to eq unit.unit_system
		expect(instance.unit.unit_type).to eq unit.unit_type
	end
end
