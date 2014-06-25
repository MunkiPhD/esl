class WorkoutTemplatesController < ApplicationController
	before_action :set_template_from_workout, only: [:new]	
	before_action :set_template, only: [:show]

	def index
		@workout_templates = current_user.workout_templates
	end

	def show
	end

	def new
		@exercises = Exercise.all
	end

	def create
		workout_template = current_user.workout_templates.build(workout_template_params)

		respond_to do |format|
			if workout_template.save
				flash[:success] = 'Workout template created.'
				format.html { redirect_to workout_templates_path }
			else
				format.html { render action: 'new' }	
			end
		end
	end

	private
	def workout_template_params
		params.require(:workout_template).permit(:name, :title, :notes, 
															  workout_exercise_templates_attributes: [ 
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

	def set_template
		@workout_template = WorkoutTemplate.find(params[:id])
	end

	def set_template_from_workout
		if params[:id].blank?
			@workout_template = WorkoutTemplate.new
			1.times { @workout_template.workout_exercise_templates.build }
			1.times { @workout_template.workout_exercise_templates[0].workout_set_templates.build }
		else
			workout = Workout.find(params[:id])
			@workout_template = WorkoutTemplate.from_workout(workout)
		end
	end
end
