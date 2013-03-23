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
      it "populates an array of workouts" do
        get :index
        expect(assigns(:workouts)).to match_array [@workout]
      end

      it "renders the :index view" do
        get :index
        response.should render_template :index
        expect(response).to render_template :index
      end
    end


    describe "GET 'show'" do
      it "assigns the requested workout to @workout" do
        get 'show', { id: @workout.id }
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

      it "renders the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

  
    describe "GET 'edit'" do
      it "assigns the requested workout to @workout" do
        get :edit, id: @workout
        expect(assigns(:workout)).to eq @workout
      end

      it "renders the :edit template" do
        get :edit, id: @workout
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the workout in the db" do
          expect {
            post :create, workout: attributes_for(:workout)
          }.to change(Workout, :count).by(1)
        end
        it "redirects to the workouts homepage" do
          post :create, workout: attributes_for(:workout)
          expect(response).to redirect_to workouts_path
        end
      end

      context "with invalid attributes" do
        it "does now save the workout to the db" do
          expect {
            post :create, workout: attributes_for(:invalid_workout)
          }.to_not change(Workout, :count)
        end

        it "re-renders the :new template" do
          post :create, workout: attributes_for(:invalid_workout)
          expect(response).to render_template :new
        end
      end
    end


    describe "PUT #update" do
      it "locates the requested workout" do
        put :update, id: @workout, workout: attributes_for(:workout)
        expect(assigns(:workout)).to eq(@workout)
      end

      context "with valid attributes" do
        it "updates the workout in the db" do
          put :update, id: @workout, workout: attributes_for(:workout, title: "test")
          @workout.reload
          expect(@workout.title).to eq("test")
        end
        it "redirects to the workout" do
          put :update, id: @workout, workout: attributes_for(:workout)
          expect(response).to redirect_to @workout
        end
      end

      context "with invalid attributes" do
        it "does not update the workout" do
          put :update, id: @workout, workout: attributes_for(:invalid_workout, title: "test")
          @workout.reload
          expect(@workout.title).to eq("test")
        end

        it "re-renders the edit template" do
          put :update, id: @workout, workout: attributes_for(:invalid_workout)
          expect(response).to render_template :edit
        end
      end
    end
    

    describe "DELETE #destroy" do
      it "deletes the message from the database" do
        expect {
          delete :destroy, id: @workout
        }.to change(Workout, :count).by(-1)
      end
      it "redirects to the workout index" do
        delete :destroy, id: @workout
        expect(response).to redirect_to workouts_path
      end
    end


    pending "nested workout_sets"
  end

  context "for un-athenticated user" do

    it "GET 'index' redirects to sign in" do
      get 'index'
      expect(response).to redirect_to(new_user_session_path)
    end

    it "GET 'show' assigns the specified workout to @workout" do
      get 'show', { id: @workout.id }
      response.should be_success
      expect(assigns(:workout)).to eq(@workout)
    end

    it "GET 'new' redirects to sign in" do
      get 'new'
      expect(response).to redirect_to(new_user_session_path)
    end

    it "GET 'edit' redirects to sign in" do
      get :edit, id: @workout.id
      expect(response).to redirect_to(new_user_session_path)
    end

    describe "POST #create" do
      it "does not save the workout to the db" do
        expect {
          post :create, workout: attributes_for(:workout)
        }.to_not change(Workout, :count)
      end

      it "redirects the user to the sign in page" do
        post :create, workout: attributes_for(:workout)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      it "does not update workout" do
        workout = create(:workout, title: "test")
        put :update, id: workout, workout: attributes_for(:workout, title: "updated")
        workout.reload
        expect(workout.title).to eq("test")
        expect(response).to redirect_to new_user_session_path
      end
      it "redirects to the workout" do
        put :update, id: @workout, workout: attributes_for(:workout)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
