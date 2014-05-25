require 'spec_helper'

describe ClassDisplayHelper do
	describe '.display_class_name' do
		it 'returns the class name in human readable form' do
			class SomeRandomClassName 
			end
			x = SomeRandomClassName.new
			expect(display_class_name(x)).to eq "Some Random Class Name"
		end
	end
end
