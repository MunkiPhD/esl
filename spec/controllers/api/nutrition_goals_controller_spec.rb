require 'rails_helper'

describe API::NutritionGoalsController, type: :controller do
	render_views
	
	let(:user) { create(:user) }

	before :each do
		sign_in user
	end

	describe 'GET index' do
		it 'returns http success' do
			get :index, format: "json"
			expect(response).to have_http_status(:success)
		end

		it 'returns the info for the nutrition goals on todays date' do
			get :index, format: "json"
			fail "for now"
		end
	end
end
