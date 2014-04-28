require 'spec_helper'

describe ExercisesController do
	context 'un-authenticated user' do
		describe "GET new" do
			it "redirects to sign in page" do
				get :new, {}
				response.should redirect_to(new_user_session_path)
			end
		end

		describe "GET show" do
			it 'renders the show template' do
				exercise = create(:exercise)
				get :show, { id: exercise }
				assigns(:exercise).should eq(exercise)
			end
		end

		it "POST create" do
			post :create, { exercise: attributes_for(:exercise) }
			response.should redirect_to(new_user_session_path)
		end

		it "PUT update" do
			exercise = create(:exercise)
			# Assuming there are no other exercises in the database, this
			# specifies that the Exercise created on the previous line
			# receives the :update_attributes message with whatever params are
			# submitted in the request.
			Exercise.any_instance.should_not_receive(:update).with({ "name" => "MyString" })
			put :update, {:id => exercise.to_param, :exercise => { "name" => "MyString" }}
			response.should redirect_to(new_user_session_path)
		end

		it "DELETE destroy" do
			exercise = create(:exercise)
			Exercise.any_instance.should_not_receive(:destroy).with({"id" => exercise.id})
			delete :destroy, { :id => exercise.to_param }
			response.should redirect_to(new_user_session_path)
		end
	end

	context 'authenticated user' do
		let(:user) { create(:user) }
		let(:valid_attributes) { build(:exercise, user_id: user.id).attributes }

		before(:each) do
			sign_in user
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

		end

		describe "GET edit" do
			it "assigns the requested exercise as @exercise" do
				exercise = Exercise.create! valid_attributes
				get :edit, {:id => exercise.to_param}
				assigns(:exercise).should eq(exercise)
			end
		end

		describe "POST create" do
			describe "with valid params" do
				it "creates a new Exercise" do
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
					Exercise.any_instance.stub(:save).and_return(false)
					post :create, {:exercise => { "name" => "invalid value" }}
					assigns(:exercise).should be_a_new(Exercise)
				end

				it "re-renders the 'new' template" do
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



			it "only updates if the exercise was created by the user" do
				exercise = FactoryGirl.create(:exercise, user_id: 99)
				Exercise.any_instance.should_not_receive(:update).with({ "id" => exercise.id })
				put :update, {:id => exercise.to_param, :exercise => exercise.attributes }
				response.should redirect_to(exercise)
			end
		end

		describe "DELETE destroy" do
			it "destroys the requested exercise" do
				exercise = Exercise.create! valid_attributes
				expect {
					delete :destroy, {:id => exercise.to_param}
				}.to change(Exercise, :count).by(-1)
			end

			it "does not destroy exercise if it belongs to a workout" do
				exercise = create(:exercise)
				workout_set = create(:workout_set, exercise: exercise)

				expect {
					delete :destroy, { :id => exercise.to_param }
				}.to_not change(Exercise, :count)
			end


			it "does not delete if not created by the user" do
				exercise = create(:exercise, user_id: 99)
				Exercise.any_instance.should_not_receive(:destroy).with({"id" => exercise.id})
				expect {
					delete :destroy, {:id => exercise.to_param}
				}.to change(Exercise, :count).by(0)
				response.should redirect_to(exercise)
			end


			it "deletes it if created by user" do
				user = create(:user)
				sign_in user
				exercise = create(:exercise, user: user)

				expect {
					delete :destroy, {:id => exercise.to_param}
				}.to change(Exercise, :count).by(-1)
				response.should redirect_to(exercises_path)
			end
		end
	end
end
