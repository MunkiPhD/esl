class ExercisesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :search]
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  # GET /exercises
  # GET /exercises.json
  def index
    @exercises = Exercise.paginate(page: params[:page])
  end

	def search
		@exercises = ExerciseSearch.filter(params).paginate(page: params[:page])

		respond_to do |format|
			format.html { render 'index' }
		end
	end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
		if current_user
			@logged_orm_workout_set = WorkoutQueries.max_weight_for_exercise_and_user(@exercise, current_user).first	
			@calculated_orm = OneRepMax.epley_formula(@logged_orm_workout_set.weight, @logged_orm_workout_set.rep_count) unless @logged_orm_workout_set.blank?
		end
  end

=begin
  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @exercise = current_user.exercises.build(exercise_params) #Exercise.new(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to @exercise, notice: 'Exercise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @exercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercises/1
  # PATCH/PUT /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.user_id != current_user.id
        format.html { redirect_to @exercise, notice: 'You cannot update an exercise not created by you.' }
        format.json { head :no_content, status: :unprocessable_entity }
      end

      if @exercise.update(exercise_params)
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    respond_to do |format|
      if @exercise.user != current_user
        format.html { redirect_to @exercise, notice: "You cannot delete an exercise you did not create."}
        format.json { head :no_content }
      elsif is_logged
        format.html { redirect_to @exercise, notice: "You cannot delete an exercise that has already been logged in a workout."}
        format.json { head :no_content }
      else
        @exercise.destroy
        format.html { redirect_to exercises_url, notice: "#{@exercise.name} was deleted." }
        format.json { head :no_content }
      end
    end
  end
=end
  private

  # verify that the exercise can be deleted
  def is_logged
		WorkoutSet.where(exercise: @exercise).count > 0
  end


  # Use callbacks to share common setup or constraints between actions.
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def exercise_params
		params.permit(:page)
    params.require(:exercise).permit(:name)
  end
end
