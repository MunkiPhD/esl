# == Schema Information
#
# Table name: body_weights
#
#  id         :integer          not null, primary key
#  log_date   :date             default(Thu, 29 May 2014), not null
#  weight     :decimal(9, 6)    not null
#  unit_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe BodyWeight do
	include Capybara::DSL

	let(:user) { create(:user) }
	let(:body_weight) { build(:body_weight, user: user) }

	it 'has a valid factory' do
		expect(body_weight).to be_valid	
	end

	describe 'validations' do
		let(:entry) { BodyWeight.new }

		before(:each) do
			entry.valid?
		end

		it 'is a number and is not null' do
			expect(entry.errors[:weight]).to include("is not a number", "can't be blank")
		end

		it 'has a user' do
			expect(entry.errors[:user]).to include("can't be blank")
		end

		it 'has a unit' do
			expect(entry.errors[:unit]).to eq []
		end
	end

	it 'before validation, it sets the unit' do
		instance  = BodyWeight.new(weight: 100, user: user)
		expect(instance).to be_valid
		expect(instance.unit.unit_system_name).to eq "US"
		expect(instance.unit.unit_type_name).to eq "weight"
	end

	describe '.unit_abbr' do
		it 'is the abbreviation for the unit of the entry' do
			expect(body_weight.unit_abbr).to eq body_weight.unit.unit_abbr
		end
	end
end
