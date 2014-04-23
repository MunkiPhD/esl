require 'spec_helper'

describe FoodLinkHelper do
	describe '.link_to_log_food' do
		it 'generates a link with correct properties' do
			food = create(:food)
			result = helper.link_to_log_food(food)

			data_attr_id = "data-id=\"#{food.id}\""
			data_attr_url = "data-url=\"#{food_log_foods_path(food)}\""

			expect(result).to include(data_attr_id)
			expect(result).to include(data_attr_url)
			expect(result).to include("link-to-log-food")
			expect(result).to include("Log Item")
		end
	end
end
