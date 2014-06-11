# == Schema Information
#
# Table name: experience_levels
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe ExperienceLevel do
	describe 'validations' do
		it 'must have a non-blank name' do
			expect(ExperienceLevel.new(name: '')).to have(1).errors_on(:name)
			expect(ExperienceLevel.new(name: nil)).to have(1).errors_on(:name)
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:experience_level, name: "some ScHlaub No0b") }
	end
end
