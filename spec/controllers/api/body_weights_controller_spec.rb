require 'rails_helper'

describe API::BodyWeightsController, type: :controller do
	render_views

	let(:user) { create(:user) }

	before(:each) do
		sign_in user
	end

	describe 'GET :index' do
		it 'returns the users body weights' do
			bw1 = create(:body_weight, user: user, weight: 200)
			bw2 = create(:body_weight, user: user, weight: 100)

			get 'index', format: "json"

			expect(response.body).to have_content [bw1, bw2].to_json(only: [:id, :log_date, :weight], methods: [:unit_abbr])
		end
	end

	describe 'POST :create' do
		it 'creates a new body weight entry' do
			body_weight = build(:body_weight, user: user, weight: 123.4)
			post :create, { format: "json", body_weight: body_weight.attributes }
			parsed_json = JSON.parse(response.body)
			 
			expect(parsed_json["body_weight"]["weight"]).to eq "#{body_weight.weight}"
		end
	end

	describe 'PUT :update' do
		it 'edits an existing entry' do
			body_weight = create(:body_weight, user: user, weight: 123)
			body_weight.weight = 321
			put :update, { format: "json", body_weight: body_weight.attributes }
			parsed_json = JSON.parse(response.body)

			expect(parsed_json["body_weight"]["weight"]).to eq "321"
		end
	end
end
