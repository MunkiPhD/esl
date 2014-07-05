class WorkoutTemplatesController < ApplicationController
	before_action :set_template_from_workout, only: [:new]	
	before_action :set_template, only: [:show, :edit, :update, :destroy]

	def index
		@workout_templates = current_user.workout_templates
	end

	def show
	end

	def new
		@exercises = Exercise.all
	end

	def create
		@workout_template = current_user.workout_templates.build(workout_template_params)

		respond_to do |format|
			if @workout_template.save
				flash[:success] = 'Workout template created.'
				format.html { redirect_to workout_templates_path }
			else
				@exercises = Exercise.all
				format.html { render action: 'new' }	
			end
		end
	end

	def edit
		@exercises = Exercise.all
	end

	def update
		respond_to do |format|
			if @workout_template.user_id != current_user.id
				flash[:error] = 'You cannot update an workout not created by you.'
				format.html { redirect_to @workout_template }
			elsif @workout_template.update(workout_template_params)
				flash[:success] = "Workout Template was successfully updated."
				format.html { redirect_to @workout_template }
			else
				@exercises = Exercise.all
				format.html { render action: 'edit' }
			end
		end
	end

	def destroy
		respond_to do |format|
			if @workout_template.user != current_user
				flash[:error] = "You cannot delete a template that does not belong to you"
				format.html { redirect_to workout_templates_path }
			end

		if @workout_template.destroy
			flash[:success] = "Template was deleted."
			format.html { redirect_to workout_templates_path }
		else
			format.html { redirect_to @workout_template }
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
