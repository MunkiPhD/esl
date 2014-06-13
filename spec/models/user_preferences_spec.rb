require 'rails_helper'

describe UserPreferences do
	it 'has a valid factory' do
		expect(build(:user_preferences)).to be_valid
	end

	it 'has a default system id that is either 0 or 1' do
		#this test might seem odd, but we only have two systems: US and Metric. Chances of another is zero. No need to make it dynamic
		user_pref = UserPreferences.new(default_system_id: -1)
		user_pref.valid?		
		expect(user_pref.errors[:default_system_id]).to include 'must be greater than or equal to 0'
		
		user_pref.default_system_id = 0
		user_pref.valid?
		expect(user_pref.errors[:default_system_id]).to eq []

		user_pref.default_system_id = 1
		user_pref.valid?		
		expect(user_pref.errors[:default_system_id]).to eq []

		user_pref.default_system_id = 2
		user_pref.valid?		
		expect(user_pref.errors[:default_system_id]).to include 'must be less than or equal to 1'
	end

	it 'cannot have a null default_system_id' do
		user_pref = UserPreferences.new(default_system_id: nil)
		user_pref.valid?
		expect(user_pref.errors[:default_system_id]).to include "can't be blank"
	end

	it 'cannot have a null user' do
		user_pref = UserPreferences.new(user: nil)
		user_pref.valid?
		expect(user_pref.errors[:user]).to include "can't be blank"
	end

	describe '#weight_unit' do
		it 'returns the correct weight unit' do
			prefs = create(:user_preferences, default_system_id: Unit.unit_systems[:us_system])
			unit = Unit.for_system(:us_system).for_unit_type(:weight).first
			expect(prefs.weight_unit).to eq unit
		end
	end

	describe '#unit_system' do
		it 'returns the selected unit systems name for US' do
			prefs = create(:user_preferences, default_system_id: Unit.unit_systems[:us_system])
			expect(prefs.unit_system).to eq 'US'
		end
		it 'returns the selected unit systems name for Metric' do
			prefs = create(:user_preferences, default_system_id: Unit.unit_systems[:metric_system])
			expect(prefs.unit_system).to eq 'METRIC'
		end
	end
end
