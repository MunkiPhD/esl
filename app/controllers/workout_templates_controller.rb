class WorkoutTemplatesController < ApplicationController
	before_action :set_workout, only: [:new]	

	def index
		@workout_templates = current_user.workout_templates
	end

	def new
		@exercises = Exercise.all
	end

	def create
		workout_template = current_user.workout_templates.build(workout_template_params)

		respond_to do |format|
			if workout_template.save
				flash[:success] = 'Workout template created.'
				format.html { redirect_to workout_tempaltes_path }
			else
				format.html { render action: 'new' }	
			end
		end
	end

	private
	def workout_tempalte_params
		params.require(:workout_template).permit(:name, :title, :notes, 
															  workout_exercise_tempaltes_attributes: [ 
																  :workout_template_id, 
																  :exercise_id, 
																  :id,
																  :_destroy, 
																  workout_set_templates_attributes: [ 
																	  :id,
																	  :workout_exercise_template_id,
																	  :workout_template_id,
																	  :exercise_id,
																	  :set_number, 
																	  :rep_count, 
																	  :weight, 
																	  :notes,
																	  :is_percent_of_one_rep_max,
																	  :percent_of_one_rep_max,
																	  :_destroy
		]
		]
															 )
	end

	def set_workout
		@workout = Workout.find(params[:id])
	end
end
