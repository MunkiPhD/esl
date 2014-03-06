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
  accepts_nested_attributes_for :workout_sets, allow_destroy: true

  default_scope  { order('date_performed DESC') }


  def self.max_weight(exercise)
=begin
#
# This is the query we want to work off of
#
SELECT workoutjoin.user_id, workoutjoin.workout_id, MAX(workoutjoin.weight) as weight
FROM (
  SELECT workouts.id as workout_id, workouts.user_id as user_id, workout_sets.weight as weight
  FROM workouts INNER JOIN workouts_sets ON workouts.id = workout_sets.workout_id
  WHERE workout_sets.exercise_id = 1) as workoutjoin
GROUP BY workoutjoin.user_id, workoutjoin.workout_id
=end
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
    Workout.select("workouts.*, t.*").from(Arel.sql("workouts, (#{subquery}) as t"))
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
