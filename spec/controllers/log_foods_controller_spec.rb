require 'rails_helper'

describe LogFoodsController, type: :controller do
  let(:user) { create(:user) }
  let(:logged_food){ create(:log_food, user: user) }

  before(:each) do
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', { food_id: logged_food.food } #path
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, { id: logged_food }
      expect(response).to be_success
    end
  end


  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, { id: logged_food }
      expect(response).to be_success
    end
  end

  describe "GET 'totals'" do
    render_views

    it 'returns correct json' do
      food = create(:food, protein: 2, carbs: 3, total_fat: 5)
      date_str = format_date(Date.today)
      food_entry = create(:log_food, user: user, log_date: date_str, servings: 2, food: food)
      get 'daily_totals', date: date_str, format: "json"

      expect(response).to be_success

      json = response.body
      parsed_response = JSON.parse(json) if json && json.length >= 2

      expect(parsed_response['protein']).to eq "4.0"
      expect(parsed_response['carbs']).to eq "6.0"
      expect(parsed_response['fat']).to eq "10.0"
      expect(Date.parse(parsed_response['date'])).to eq food_entry.log_date
    end
  end
end
