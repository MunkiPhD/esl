class WorkoutTemplatesController < ApplicationController
	before_action :set_template_from_workout, only: [:new]	
	before_action :set_template, only: [:show]

	def index
		@workout_templates = current_user.workout_templates
	end

	def show

	end

	def new
		puts "----------- inside new ------------------"
		@exercises = Exercise.all
		if @workout_template.nil?
			@workout_template = WorkoutTemplate.new
		end
	end

	def create
		workout_template = current_user.workout_templates.build(workout_template_params)

		puts "------ is it valid?: #{workout_template.valid?}"
		if !workout_template.valid?
			workout_template.errors.full_messages.each do |msg|
				puts msg
			end
		end

		puts "---------- end messages ----------- "

		respond_to do |format|
			if workout_template.save
				flash[:success] = 'Workout template created.'
				format.html { redirect_to workout_templates_path }
			else
				puts "--------- it didnt save ---------"
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
		puts "------------------ inside set_template-from_workout -----------------"
		puts "params: #{params}"
		workout = Workout.find(params[:id])
		@workout_template = WorkoutTemplate.from_workout(workout)
		puts "got to here..."
	end
end
