# == Schema Information
#
# Table name: workouts
#
#  id             :integer          not null, primary key
#  title          :string(255)      not null
#  date_performed :date             not null
#  notes          :text             default(""), not null
#  user_id        :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#



class Workout < ActiveRecord::Base
  before_validation :prepare_workout_for_validation

  belongs_to :user
  has_many :workout_exercises, :dependent => :destroy, inverse_of: :workout
  has_many :workout_sets, :dependent => :destroy, inverse_of: :workout

  validates :title, presence: true, length: {minimum: 2, maximum: 200}
  validates :user_id, presence: true
  validates :date_performed, presence: true
  validates :notes, presence: true, allow_blank: true

  accepts_nested_attributes_for :workout_exercises, allow_destroy: true
	
  #default_scope  { order('date_performed DESC') }
  scope :date_desc, ->  { order('workouts.date_performed DESC') }
	scope :for_user, -> (user) { where("workouts.user_id = ?", user) }



	def self.from_template(workout_template)
		@workout = Workout.new #(title: workout_template.title)
			1.times { @workout.workout_exercises.build }
			1.times { @workout.workout_exercises[0].workout_sets.build }
=begin	
		workout_template.workout_exercise_templates.each do |workout_exercise_template|
			puts "Adding exercise #{workout_exercise_template.exercise_name}"
			puts "WE: #{workout_exercise_template.inspect}"
			puts "Attribs: #{workout_exercise_template.attributes}"
			puts "Workout e count: #{workout.workout_exercises.count}"
			
			workout.workout_exercises.build
		end
=end

		return @workout
	end


  def self.max_weight(exercise)
    selected_fields = <<-SELECT
      workouts.id AS workout_id, 
      workout_sets.weight,
      workout_sets.id AS workout_set_id,
      workout_exercises.exercise_id AS exercise_id,
      ROW_NUMBER() OVER (
        PARTITION BY workouts.user_id 
        ORDER BY workout_sets.weight DESC, workouts.id DESC) as rowNum
    SELECT

    subquery = Workout.joins(workout_exercises: :workout_sets).select(selected_fields).for_exercise(exercise).to_sql
    Workout.select("workouts.*, t.*, COUNT(id)").from(Arel.sql("workouts, (#{subquery}) as t"))
    .where("t.rowNum = 1 AND workouts.id = t.workout_id")
    .order("t.weight DESC")
=begin
    # Workout.joins(:workout_sets).for_exercise(exercise).order("workout_sets.weight DESC")
    #WorkoutSet.where("exercise_id = ?", exercise.id).order("workout_sets.weight DESC").workout
    joins(:workout_sets).for_exercise(exercise).order("workout_sets.weight DESC")
=end

  end


  def self.for_exercise(exercise)
    where("workout_sets.exercise_id = ?", exercise.id)
  end

  private


  # makes sure that the correct IDs are set for all the workout sets
  def prepare_workout_for_validation
    begin
      workout_exercises.each do |workout_exercise|
        workout_exercise.workout_sets.each do |workout_set|
          workout_set.workout = self
          workout_set.exercise = workout_exercise.exercise
        end
      end
    rescue => e
      logger.info "!----- error occured while massaging the workout #{e}"
    end
  end
end
