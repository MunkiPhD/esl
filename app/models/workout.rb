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

  scope :latest, -> { order('date_performed DESC') }

  def self.max_weight
    #join workout_exercises on workout.id, join workout_sets on workout_exercise.id, select maximum(workout_sets.weight)
    #joins(workout_exercises: :workout_sets).order("workout_sets.weight DESC").select("workouts.*, max(workout_sets.weight)").group("workouts.user_id")
    #col_names = []
    #col_names << Workout.column_names.map { |col| "\"workouts\".\"#{col.name}\"" }
    #joins(workout_exercises: :workout_sets).group("workouts.id, workouts.title, workouts.date_performed, workouts.notes, workouts.user_id, workouts.created_at, workouts.updated_at").select("workouts.*, MAX(workout_sets.weight)")
    #where(id: joins(workout_exercises: :workout_sets).order("workout_sets.weight DESC").group("user_id, workouts.id, workout_sets.weight, workouts.date_performed").select("workouts.id").pluck(:id, :user_id))
=begin
    find_by_sql("SELECT workouts.id, workouts.user_id 
                FROM workouts 
                JOIN (
                  SELECT workouts.id, workouts.user_id, MAX(workout_sets.weight) as max_weight
                  FROM workouts
                  INNER JOIN workout_exercises ON workout_exercises.workout_id = workouts.id
                  INNER JOIN workout_sets ON workout_sets.workout_exercise_id = workout_exercises.id
                  GROUP BY workouts.user_id, workouts.id, workout_sets.weight) x ON x.workouts.id = workouts.id
                                                                                AND x.user_id = workouts.user_id
                  ")
=end
  

    #join_query = Workout.joins(workout_exercises: :workout_sets)
    #user_group_query = join_query.group("workouts.user_id").select("workouts.user_id, MAX(workout_sets.weight) AS workout_sets.weight")
    #workout_query = user_group_query.where("workouts.user_id = workouts_user_id AND workout_sets.weight = user_max_weight")
    #workout_query_2 = join_query.joins(user_group_query)
    #where(id: Workout.joins(workout_exercises: :workout_sets).order("workouts.user_id, workout_sets.weight DESC").select("workouts.user_id").uniq)

    #where(id: join_query.order("workouts.id, workouts.user_id, workout_sets.weight DESC")).select("DISTINCT(workouts.id), workouts.*").workouts.user_id").uniq
#where(id: join_query.select("workouts.user_id, workout_exercises.exercise_id, MAX(workout_sets.weight)").group("workouts.user_id, workout_exercises.exercise_id"))
  end
end
