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
	it_behaves_like 'nice urls' do
		let(:model) { create(:mechanic_type) }
	end

	describe 'validations' do
		it 'must have a non-blank name' do
			mechanic_type = MechanicType.new(name: '')
			mechanic_type.valid?
			expect(mechanic_type.errors[:name]).to include "can't be blank"
		end
	end
end
