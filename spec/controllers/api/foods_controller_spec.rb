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
	end
end
