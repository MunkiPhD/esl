require 'spec_helper'

describe ExperienceLevel do
	describe 'validations' do
		it 'must have a non-blank name' do
			expect(ExperienceLevel.new(name: '')).to have(1).errors_on(:name)
			expect(ExperienceLevel.new(name: nil)).to have(1).errors_on(:name)
		end
	end
end
