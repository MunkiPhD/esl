require 'rails_helper'

describe API::FoodsController, type: :controller do
	render_views

	let(:user) { create(:user) }
	before :each do
		sign_in user
	end

	describe "GET 'search'" do
		it 'returns http success' do
			get :search, format: "json"
			expect(response).to have_http_status(:success)
		end

		it 'returns search results' do
			food_one = create(:food, name: "test")
			food_two = create(:food, name: "bread")

			get :search, { format: "json", search: "est" }
			parsed_json = JSON.parse(response.body)
			expect(response.status).to eq 201

			json_food = parsed_json[0]
			expect(json_food["name"]).to eq food_one.name
			expect(json_food["id"]).to eq food_one.id
		end
	end
end
