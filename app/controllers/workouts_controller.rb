class WorkoutsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_workout, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json, only: [:index, :show]

  def index
    @workouts = current_user.workouts
  end

  def show
  end

  def new
    @exercises = Exercise.all
    @workout = Workout.new
    1.times { @workout.workout_exercises.build }
    1.times { @workout.workout_exercises[0].workout_sets.build }
  end

  def create
    @workout = current_user.workouts.build(workout_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to workouts_path, notice: 'Workout was successfully created.' }
        format.json { render action: 'show', status: :created, location: @workout }
      else
        @exercises = Exercise.all
        format.html { render action: 'new' }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @exercises = Exercise.all
  end

  def update
    respond_to do |format|
      if @workout.user_id != current_user.id
        format.html { redirect_to @workout, notice: 'You cannot update an workout not created by you.' }
        format.json { head :no_content, status: :unprocessable_entity }
      end

      if @workout.update(workout_params)
        format.html { redirect_to @workout, notice: 'Exercise was successfully updated.' }
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
        format.html { redirect_to @workout, notice: "You cannot delete a workout you did not create"}
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_workout
    @workout= Workout.find(params[:id])
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
                                        :set_number, 
                                        :rep_count, 
                                        :weight, 
                                        :notes,
                                        :_destroy
                                      ]
                                    ]
                                   )
  end
end
