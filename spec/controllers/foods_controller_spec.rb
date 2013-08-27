require 'spec_helper'

describe FoodsController do
  let(:bread) { create(:bread) }
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'search'" do
    it "returns http success" do
      get :search
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, { :id => bread.to_param }
      assigns(:food).should eq(bread)
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, { :id => bread.to_param }
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get :destroy, { :id => bread.to_param }
      response.should be_success
    end
  end

end
