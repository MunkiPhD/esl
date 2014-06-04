require 'spec_helper'

describe UserPreferences do
	it 'has a valid factory' do
		expect(build(:user_preferences)).to be_valid
	end

	it 'cannot have a null default_system_id' do
		expect(UserPreferences.new(default_system_id: nil)).to have(1).errors_on(:default_system_id)
	end

	it 'cannot have a null user' do
		expect(UserPreferences.new(user: nil)).to have(1).errors_on(:user)
	end

	describe '#weight_unit' do
	it 'returns the correct weight unit' do
		prefs = create(:user_preferences, default_system_id: Unit.unit_systems[:us_system])
		unit = Unit.for_system(:us_system).for_unit_type(:weight).first
		expect(prefs.weight_unit).to eq unit
	end
	end
end
