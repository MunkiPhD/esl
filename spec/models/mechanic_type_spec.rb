# == Schema Information
#
# Table name: mechanic_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe MechanicType do
	describe 'validations' do
		it 'must have a non-blank name' do
			expect(MechanicType.new(name: '')).to have(1).errors_on(:name)
			expect(MechanicType.new(name: nil)).to have(1).errors_on(:name)
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:mechanic_type) }
	end
end
