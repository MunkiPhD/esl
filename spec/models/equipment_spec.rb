require 'spec_helper'

describe Equipment do
	describe 'validations' do
		it 'must have a non-blank name' do
			expect(Equipment.new(name: '')).to have(1).errors_on(:name)
			expect(Equipment.new(name: nil)).to have(1).errors_on(:name)
		end
	end
end
