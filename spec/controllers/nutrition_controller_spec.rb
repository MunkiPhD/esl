require 'spec_helper'

describe NutritionController do
  describe "GET 'index'" do
    it "returns http success" do
      sign_in create(:user)
      get 'index'
      response.should be_success
    end

    it 'redirects a visitor' do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end
  end

end
