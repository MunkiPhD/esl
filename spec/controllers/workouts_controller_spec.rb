require 'rails_helper'

describe WorkoutsController, type: :controller do
	let(:user) { create(:user) }
	let(:workout) { create(:workout, user_id: user.id) }

	context "for authenticated user" do
		before :each do
			sign_in user
		end

		describe "GET 'index'" do
			it "populates an array of workouts" do
				get :index
				expect(assigns(:workouts)).to match_array [workout]
			end

			it "renders the :index view" do
				get :index
				expect(response).to render_template :index
			end

			it "returns list in order of date performed" do
				user2 = create(:user)
				sign_in user2

				workout = create(:workout, date_performed: DateTime.now.tomorrow.to_date, user: user2)
				workout2 = create(:workout, date_performed: DateTime.now, user: user2)
				get :index
				expect(assigns(:workouts)).to eq [workout, workout2]
			end

			context "JSON" do
				render_views
				it "returns JSON formatted content" do
					workout1 = create(:workout, user: user, date_performed: DateTime.now)
					workout2 = create(:workout, user: user, date_performed: DateTime.now.tomorrow.to_date)
					get :index, format: :json
					expect(response.body).to have_content [workout2, workout1].to_json(only: [:id, :title, :date_performed, :notes, :user_id ])
				end
			end
		end


		describe "GET 'show'" do
			render_views

			it "assigns the requested workout to workout" do
				get 'show', { id: workout.id, username: workout.user.username }
				expect(assigns(:workout)).to eq(workout)
			end

			it "renders the :show template" do
				get :show, id: workout.id, username: workout.user.username
				expect(response).to render_template :show
			end

			it "returns JSON data" do
				get :show, format: :json, id: workout, username: workout.user.username
				expect(response.body).to have_content workout.to_json(only:  [:id, :title, :date_performed, :notes, :user_id, :workout_exercises])
			end

			it "returns JSON data for the entire workout with sets" do
				#pending "find a way to make this test pass with the correct json data"
				# the actual controller returns what I want, but i can't figure out how to create the data here
				workout = create(:workout_with_exercises, user: user)
				get :show, format: :json, id: workout.id, username: user.username
				json_data = user.workouts.find(workout.id).to_json(
					:only => [:id, :title, :date_performed, :notes, :user_id],
					:include => { :workout_exercises => 
						{ :include => { 
							:workout_sets => { :only => [:id, :workout_exercise_id, :set_number, :rep_count, :weight, :notes] }
						},  
							:only => [:id, :workout_id, :exercise_id] 
						}
				}
				)
				expect(response.body).to have_content(json_data) #Workout.includes(:workout_exercises).find(workout).to_json())
			end
		end

		describe "GET 'new'" do
			it "assigns a new workout to workout" do
				get 'new'
				expect(assigns(:workout)).to be_a_new(Workout)
			end

			it "renders the new template" do
				get :new
				expect(response).to render_template :new
			end
		end


		describe "GET 'edit'" do
			it "assigns the requested workout to workout" do
				get :edit, id: workout, username: workout.user.username
				expect(assigns(:workout)).to eq workout
			end

			it "renders the :edit template" do
				get :edit, id: workout, username: workout.user.username
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
				it "redirects to the newly created workout" do
					post :create, workout: attributes_for(:workout)
					expect(response).to redirect_to Workout.last
				end

				it "saves with workout exercises" do
					expect {
						post :create, workout: attributes_for(:workout_with_exercises)
					}.to change(Workout, :count).by(1)
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
				put :update, id: workout, workout: attributes_for(:workout)
				expect(assigns(:workout)).to eq(workout)
			end

			context "with valid attributes" do
				it "updates the workout in the db" do
					put :update, id: workout, workout: attributes_for(:workout, title: "test")
					workout.reload
					expect(workout.title).to eq("test")
				end
				it "redirects to the workout" do
					put :update, id: workout,  username: workout.user.username, workout: attributes_for(:workout)
					expect(response).to redirect_to workout
				end
			end

			context "with invalid attributes" do
				it "does not update the workout" do
					put :update, id: workout, username: workout.user.username,  workout: attributes_for(:invalid_workout, title: "test")
					workout.reload
					expect(workout.title).to eq("test")
				end

				it "re-renders the edit template" do
					put :update, id: workout, username: workout.user, workout: attributes_for(:invalid_workout)
					expect(response).to render_template :edit
				end
			end
		end


		describe "DELETE #destroy" do
			it "deletes the workout from the database" do
				workout = create(:workout, user_id: user.id)
				expect {
					delete :destroy, { "id" => "#{workout.id}", "username" => "#{user.username}" }
				}.to change(Workout, :count).by(-1)
			end

			it "redirects to the workout index" do
				delete :destroy, id: workout
				expect(response).to redirect_to workouts_path
			end
		end
	end

	context "for un-athenticated user" do
		it "GET 'index' redirects to sign in" do
			get 'index'
			expect(response).to redirect_to(new_user_session_path)
		end

		it "GET 'show' assigns the specified workout to workout" do
			get 'show', { id: workout.id, username: workout.user.username }
			expect(response).to redirect_to root_path
		end

		it "GET 'new' redirects to sign in" do
			get 'new'
			expect(response).to redirect_to(new_user_session_path)
		end

		it "GET 'edit' redirects to sign in" do
			get :edit, id: workout.id, username: workout.user.username 
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
				put :update, id: workout, workout: attributes_for(:workout)
				expect(response).to redirect_to new_user_session_path
			end
		end
	end
end
