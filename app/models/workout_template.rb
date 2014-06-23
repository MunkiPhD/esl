# == Schema Information
#
# Table name: workout_templates
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  notes      :text             default(""), not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class WorkoutTemplate < ActiveRecord::Base
	before_validation :prepare_workout_for_validation
	before_save :set_name

	belongs_to :user
	has_many :workout_exercise_templates, :dependent => :destroy, inverse_of: :workout_template
	has_many :workout_set_templates, :dependent => :destroy, inverse_of: :workout_template

	accepts_nested_attributes_for :workout_exercise_templates, allow_destroy: true

	validates :user, presence: true	
	validates :title, presence: true	

	def self.for_user(user)
		where(user: user)
	end

	def self.with_title(title)
		where(title: title)
	end

	def self.from_workout(workout)
		template = WorkoutTemplate.new
		template.title = workout.title
		template.user = workout.user
		template.notes = workout.notes
		workout.workout_exercises.each do |we|
			template.workout_exercise_templates << WorkoutExerciseTemplate.from_workout_exercise(we)
		end
		template
	end

	private

	def set_name
		template_count = WorkoutTemplate.for_user(self.user).with_title(self.title).count
		if template_count > 0
			self.title += " (#{template_count + 1})"
		end
	end
	def prepare_workout_for_validation
		begin
			workout_exercise_templates.each do |workout_exercise|
				workout_exercise.workout_set_templates.each do |workout_set|
					workout_set.workout_template = self
					workout_set.exercise = workout_exercise.exercise
				end
			end
		rescue => e
			logger.info "!----- error occured while massaging the workout template before_validation #{e}"
		end
	end
end
