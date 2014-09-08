require 'rails_helper'

describe API::LogFoodsController, type: :controller do
	render_views

	let(:user) { create(:user) }

	before :each do
		sign_in user
	end

	describe "POST 'create' json" do
		it 'creates the item and returns correct details' do
			food = create(:food)
			log_food = build(:log_food, user: user, food: food)
			post :create, { :format => 'json', :log_food => log_food.attributes, :food_id => food.id }
			parsed_json = JSON.parse(response.body)
			expect(response.status).to eq 201
			expect(parsed_json["food_name"]).to eq food.name
			expect(parsed_json["log_food"]["servings"]).to eq sprintf("%.02f", log_food.servings)
		end

		it 'returns errors if missing attributes' do
			food = create(:food)
			post :create, { :format => 'json', :log_food => { trash: "test"}, :food_id => food.id}
			expect(response.status).to eq 422
		end
	end
end
