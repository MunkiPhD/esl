require 'spec_helper'

describe LogFoodsController do
  let(:logged_food){ create(:log_food) }
  before(:each) do
    @user = FactoryGirl.create(:user) #User.new(id: 1)
    sign_in @user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
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
