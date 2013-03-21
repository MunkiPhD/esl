class WorkoutsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_workout, only: [:show, :edit, :update, :destroy]

  def index
    @workouts = current_user.workouts
  end

  def show
  end

  def new
    @workout = Workout.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout= Workout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_params
      params.require(:workout).permit(:name, :title, :date_performed, :notes)
    end
end
