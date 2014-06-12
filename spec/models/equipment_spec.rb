# == Schema Information
#
# Table name: equipment
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Equipment do
	describe 'validations' do
		it_behaves_like 'nice urls' do
			let(:model) { create(:equipment) }	
		end

		it 'cannot have a blank name' do
			equipment = Equipment.new(name: nil)
			equipment.valid?
			expect(equipment.errors[:name]).to include("can't be blank")
		end
	end
end
