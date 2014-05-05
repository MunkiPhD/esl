class WorkoutsController < ApplicationController
	before_filter :authenticate_user!, except: [:show]
	before_action :set_workout, only: [:show, :edit, :update, :destroy]
	before_action :authorize_show, only: [:show]
	authorize_resource
	respond_to :html, :json, only: [:index, :show]

	def index
		params[:username] ||= current_user.username
		@user = User.find_by_username(params[:username])
		@workouts = @user.workouts.date_desc
	end

	def show
	end

	def new
		@new_exercise = Exercise.new
		@exercises = Exercise.all
		@workout = Workout.new
		1.times { @workout.workout_exercises.build }
		1.times { @workout.workout_exercises[0].workout_sets.build }
	end

	def create
		@workout = current_user.workouts.build(workout_params)

		#@workout.prepare_workout_for_save

		respond_to do |format|
			if @workout.save
				flash[:success] = 'Workout was successfully created.'
				format.html { redirect_to @workout }
				format.json { render action: 'show', status: :created, location: @workout }
			else
				@exercises = Exercise.all
				@new_exercise = Exercise.new
				format.html { render action: 'new' }
				format.json { render json: @workout.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@exercises = Exercise.all
		@new_exercise = Exercise.new
	end

	def update
		respond_to do |format|
			if @workout.user_id != current_user.id
				flash[:error] = 'You cannot update an workout not created by you.'
				format.html { redirect_to @workout }
				format.json { head :no_content, status: :unprocessable_entity }
			elsif @workout.update(workout_params)
				flash[:success] = "Workout was successfully updated."
				format.html { redirect_to @workout }
				format.json { head :no_content }
			else
				@exercises = Exercise.all
				format.html { render action: 'edit' }
				format.json { render json: @workout.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		respond_to do |format|
			if @workout.user_id == current_user.id
				@workout.destroy
				format.html { redirect_to workouts_url }
				format.json { head :no_content }
			else
				flash[:info] = "You cannot delete a workout that does not belong to you!"
				format.html { redirect_to @workout }
				format.json { head :no_content }
			end
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_workout
		params[:username] ||= current_user.username
		@workout= User.find(params[:username]).workouts.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def workout_params
		params.require(:workout).permit(:name, :title, :date_performed, :notes, 
												  workout_exercises_attributes: [ 
													  :workout_id, 
													  :exercise_id, 
													  :id,
													  :_destroy, 
													  workout_sets_attributes: [ 
														  :id,
														  :workout_exercise_id,
														  :workout_id,
														  :exercise_id,
														  :set_number, 
														  :rep_count, 
														  :weight, 
														  :notes,
														  :_destroy
		]
		]
												 )
	end


	def authorize_show
		# check that the users arent the same. If they are, you could have the case where they are not in any 
		# circles, in which case it with throw an AccessDenied exception
		# - in other words, you should only be able to view your workouts and those of people in the same circle(s) as yourself
		unless @workout.user == current_user
			raise CanCan::AccessDenied if Circle.intersecting_groups(@workout.user, current_user).empty?
		end
	end
end
