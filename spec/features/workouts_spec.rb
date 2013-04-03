require 'spec_helper'

describe "Workouts" do
  context "authenticated users" do
    before :each do
      @user = create(:user)
      sign_in @user
    end

    describe "GET /workouts" do
      it "response is 200" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        get workouts_path
        response.status.should be(200)
      end
    end
  end

  context "un-authenticated users" do
    it "redirects them to the sign in page" do
      get workouts_path
      response.status.should be (302)
    end
  end
end
