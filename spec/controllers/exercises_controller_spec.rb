require 'spec_helper'

describe ExercisesController do

  # This should return the minimal set of attributes required to create a valid
  # Exercise. As you add validations to Exercise, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    FactoryGirl.build(:exercise, user_id: @user.id).attributes
    #FactoryGirl.build(:exercise, user_id: @user.id).attributes
   # { "name" => "MyString" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ExercisesController. Be sure to keep this updated too.
  #
  # Taking out valid_session as it's being handles by devise at the moment
  # def valid_session
  #  {}
  # end
  
  before(:each) do
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user) #User.new(id: 1)
    sign_in @user
    #controller.stub(:current_user).and_return(@user)
    #controller.stub(:authenticate_user!).and_return true
  end

  describe "GET index" do
    it "assigns all exercises as @exercises" do
      exercise = Exercise.create! valid_attributes
      get :index, {}
      assigns(:exercises).should eq([exercise])
    end
  end

  describe "GET show" do
    it "assigns the requested exercise as @exercise" do
      exercise = Exercise.create! valid_attributes
      get :show, {:id => exercise.to_param}
      assigns(:exercise).should eq(exercise)
    end
  end

  describe "GET new" do
    it "assigns a new exercise as @exercise" do
      get :new, {}
      assigns(:exercise).should be_a_new(Exercise)
    end

    describe "for unauthenticated user" do
      it "redirects to sign in page" do
        sign_out @user
        get :new, {}
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested exercise as @exercise" do
      exercise = Exercise.create! valid_attributes
      get :edit, {:id => exercise.to_param}
      assigns(:exercise).should eq(exercise)
    end
  end

  describe "POST create" do
    describe "with un-authenticated user" do
      pending "it redirects to sign in page"
    end

    describe "with valid params" do
      it "creates a new Exercise" do
        #post :create, {:exercise => valid_attributes}, valid_session
          #post :create, { exercise: build(:exercise).attributes }, valid_session
        expect {
          post :create, {:exercise => valid_attributes}
        }.to change(Exercise, :count).by(1)
      end

      it "assigns a newly created exercise as @exercise" do
        post :create, {:exercise => valid_attributes}
        assigns(:exercise).should be_a(Exercise)
        assigns(:exercise).should be_persisted
      end

      it "redirects to the created exercise" do
        post :create, {:exercise => valid_attributes}
        response.should redirect_to(Exercise.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved exercise as @exercise" do
        # Trigger the behavior that occurs when invalid params are submitted
        Exercise.any_instance.stub(:save).and_return(false)
        post :create, {:exercise => { "name" => "invalid value" }}
        assigns(:exercise).should be_a_new(Exercise)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Exercise.any_instance.stub(:save).and_return(false)
        post :create, {:exercise => { "name" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested exercise" do
        exercise = Exercise.create! valid_attributes
        # Assuming there are no other exercises in the database, this
        # specifies that the Exercise created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Exercise.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => exercise.to_param, :exercise => { "name" => "MyString" }}
      end

      it "assigns the requested exercise as @exercise" do
        exercise = Exercise.create! valid_attributes
        put :update, {:id => exercise.to_param, :exercise => valid_attributes}
        assigns(:exercise).should eq(exercise)
      end

      it "redirects to the exercise" do
        exercise = Exercise.create! valid_attributes
        put :update, {:id => exercise.to_param, :exercise => valid_attributes}
        response.should redirect_to(exercise)
      end
    end

    describe "with invalid params" do
      it "assigns the exercise as @exercise" do
        exercise = Exercise.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Exercise.any_instance.stub(:save).and_return(false)
        put :update, {:id => exercise.to_param, :exercise => { "name" => "invalid value" }}
        assigns(:exercise).should eq(exercise)
      end

      it "re-renders the 'edit' template" do
        exercise = Exercise.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Exercise.any_instance.stub(:save).and_return(false)
        put :update, {:id => exercise.to_param, :exercise => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested exercise" do
      exercise = Exercise.create! valid_attributes
      expect {
        delete :destroy, {:id => exercise.to_param}
      }.to change(Exercise, :count).by(-1)
    end

    it "redirects to the exercises list" do
      exercise = Exercise.create! valid_attributes
      delete :destroy, {:id => exercise.to_param}
      response.should redirect_to(exercises_url)
    end
  end

end
