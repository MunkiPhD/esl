require 'rails_helper'

describe API::FoodsController, type: :controller do
	render_views

	let(:user) { create(:user) }

	before :each do
		sign_in user
		Food.delete_all
	end

	describe "GET 'search'" do
		it 'returns http success' do
			get :search, { format: "json", search: "some string" }
			expect(response).to have_http_status(:success)
		end

		it 'for no results returns an empty string' do
			get :search, { format: "json", search: "121j9nuhu9h9uh19uh19eh" }

			parsed_json = JSON.parse(response.body)
			expect(parsed_json["foods"].size).to eq 0
		end

		it 'returns search results' do
			food_one = create(:food, name: "test")
			food_two = create(:food, name: "bread")

			get :search, { format: "json", search: "t" }
			parsed_json = JSON.parse(response.body)

			json_food = parsed_json["foods"][0]
			expect(parsed_json["foods"].size).to eq 1
			expect(json_food["name"]).to eq food_one.name
			expect(json_food["id"]).to eq food_one.id
		end


		it 'returns correct paged results' do
			parsed_json = create_and_issue_request(3)
			expect(parsed_json["foods"].size).to eq 3
		end


		it 'has the correct meta data on the result count' do
			parsed_json = create_and_issue_request
			expect(parsed_json["results"]["count"]).to eq 28
		end


		it 'has the current page number' do
			parsed_json = create_and_issue_request
			expect(parsed_json["results"]["page"]).to eq 1
		end


		it 'has the total number of pages' do
			parsed_json = create_and_issue_request(35)
			expect(parsed_json["results"]["page_count"]).to eq 2
		end


		def create_and_issue_request(size = 28)
			for i in 1..size
				create(:food, name: "food#{i}")
			end

			get :search, { format: "json", search: "food" }
			parsed_json = JSON.parse(response.body)
			return parsed_json
		end
	end
end
