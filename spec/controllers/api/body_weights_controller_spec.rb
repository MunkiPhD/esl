require 'rails_helper'

describe API::BodyWeightsController, type: :controller do
	render_views

	before(:each) do
		@user = create(:user)
		sign_in @user
	end

	describe 'GET :index' do
		it 'returns the users body weights' do
			bw1 = create(:body_weight, user: @user, weight: 200)
			bw2 = create(:body_weight, user: @user, weight: 100)

			get 'index', format: "json"

			expect(response.body).to have_content [bw1, bw2].to_json(only: [:id, :log_date, :weight], methods: [:unit_abbr])
		end
	end
end
