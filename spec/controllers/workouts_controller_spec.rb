require 'spec_helper'

describe WorkoutsController do
  before :each do
      @user = create(:user)
      @workout = create(:workout, user_id: @user.id)
  end

  context "for authenticated user" do
    before :each do
      sign_in @user
    end

    describe "GET 'index'" do
      it "returns a users workouts" do
        get 'index'
        response.should be_success
        expect(assigns(:workouts)).to eq([@workout])
      end
    end


    describe "GET 'show'" do
      it "assigns the requested workout to @workout" do
        get 'show', { id: @workout.id }
        response.should be_success
        expect(assigns(:workout)).to eq(@workout)
      end

      it "renders the :show template" do
        get :show, id: @workout.id
        expect(response).to render_template :show
      end

    end

    describe "GET 'new'" do
      it "assigns a new workout to @workout" do
        get 'new'
        expect(assigns(:workout)).to be_a_new(Workout)
      end
    end

  
    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', { id: @workout.id }
        response.should be_success
      end
    end

    pending "nested workout_sets"
  end

  context "for un-athenticated user" do

    it "GET 'index' redirects to sign in" do
      get 'index'
      response.should redirect_to(new_user_session_path)
    end

    it "GET 'show' is a success" do
      get 'show', { id: @workout.id }
      response.should be_success
      expect(assigns(:workout)).to eq(@workout)
    end

    it "GET 'new' redirects to sign in" do
      get 'new'
      response.should redirect_to(new_user_session_path)
    end

    it "GET 'edit' redirects to sign in" do
      get :edit, id: @workout.id
      response.should redirect_to(new_user_session_path)
    end

    it "POST 'create' redirects to sign in" do
      get 'create'
      response.should redirect_to(new_user_session_path)
    end
  end
end
