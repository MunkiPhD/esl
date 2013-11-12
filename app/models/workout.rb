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
  belongs_to :user
  has_many :workout_exercises, :dependent => :destroy, inverse_of: :workout

  validates :title, presence: true, length: {minimum: 2, maximum: 200}
  validates :user_id, presence: true
  validates :date_performed, presence: true
  validates :notes, presence: true, allow_blank: true

  accepts_nested_attributes_for :workout_exercises, allow_destroy: true

  default_scope  { order('date_performed DESC') }


  def self.max_weight(exercise)
=begin
    selected_fields = <<-SELECT
        workouts.id AS workout_id, 
        workout_sets.weight AS weight,
        workout_sets.id AS workout_set_id,
        workout_exercises.exercise_id AS exercise_id,
        ROW_NUMBER() OVER (
           PARTITION BY workouts.user_id 
           ORDER BY workout_sets.weight DESC, workouts.id DESC) as row_num
      SELECT

    joins(", (#{Workout.joins(workout_exercises: :workout_sets).select(selected_fields).to_sql}) as t")
              .select("workouts.*, t.*")
              .where("workouts.id = t.workout_id AND t.row_num = 1") # AND workouts.user_id IN (#{resource_ids.join(",")})")
              .order("t.weight DESC")
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
  end

  private
  def self.for_exercise(exercise)
    where("exercise_id = ?", exercise.id)
  end
end
