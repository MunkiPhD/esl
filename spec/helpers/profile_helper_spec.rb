require 'rails_helper'

describe ProfileHelper do
	describe '#height' do

		context 'for imperial systems' do
			it 'displays a height in common format for inches' do
				prefs = create(:user_preferences)
				user = prefs.user
				user.height = 70
				user.save!

				result = helper.height(user)
				expect(result).to eq "5' 10\" (1.78 m)"
			end
		end

		context 'for metric systems' do
			it 'displays height in correct format for centimeters' do
			prefs = create(:user_preferences_metric)
			user = prefs.user
			user.height = 178
			user.save!

			result = helper.height(user)
			expect(result).to eq "1.78 m (5' 10\")"
			end
		end

		it 'returns "unknown" if null' do
			user = create(:user, height: nil)
			result = helper.height(user)
			expect(result).to eq "unknown"
		end
	end
end
