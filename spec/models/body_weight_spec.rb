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

	it 'before validation, it sets the unit' do
		instance  = BodyWeight.new(weight: 100, user: user)
		expect(instance).to be_valid
		expect(instance.unit.unit_system_name).to eq "US"
		expect(instance.unit.unit_type_name).to eq "weight"
	end
end
