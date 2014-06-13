# == Schema Information
#
# Table name: force_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe ForceType do
	describe 'validations' do
		it 'cannot have a blank name' do
			force_type = ForceType.new(name: nil)
			force_type.valid?
			expect(force_type.errors[:name]).to include "can't be blank"
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:force_type) }
	end
end
