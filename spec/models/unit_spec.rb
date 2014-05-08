require 'spec_helper'

describe Unit do
	it 'cannot be validated' do
		expect { Unit.new().valid?	}.to raise_error
	end

	it 'cannot be saved' do
		expect { Unit.new().save }.to raise_error
	end
end
