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
			experience = ExperienceLevel.new(name: '')
			experience.valid?
			expect(experience.errors[:name]).to include "can't be blank"
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:experience_level, name: "some ScHlaub No0b") }
	end
end
