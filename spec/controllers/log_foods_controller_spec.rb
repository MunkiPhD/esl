require 'spec_helper'

describe LogFoodsController do
  let(:user) { create(:user) }
  let(:logged_food){ create(:log_food, user: user) }

  before(:each) do
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', { food_id: logged_food.food } #path
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, { id: logged_food }
      response.should be_success
    end
  end


  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, { id: logged_food }
      response.should be_success
    end
  end

end
