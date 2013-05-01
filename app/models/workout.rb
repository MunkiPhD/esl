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

      find_by_sql("
        WITH joined_table AS (
          SELECT workout_sets.weight AS weight, 
            workouts.user_id AS user_id, 
            workouts.id AS workout_id, 
        		workout_sets.id AS workout_set_id,
        		workout_exercises.exercise_id AS exercise_id
        	FROM workouts 
        	INNER JOIN workout_exercises ON workout_exercises.workout_id = workouts.id 
        	INNER JOIN workout_sets ON workout_sets.workout_exercise_id = workout_exercises.id       
        	ORDER BY workout_sets.weight DESC
        	),
        
        result_set AS (
        	SELECT MAX(x.workout_id) AS workout_id, x.user_id, x.weight, x.workout_set_id, x.exercise_id
        	FROM joined_table x
          JOIN (SELECT p.user_id, MAX(weight) as weight
        		FROM joined_table p
        		GROUP BY p.user_id) y 
        	ON y.user_id = x.user_id AND y.weight = x.weight
        	GROUP BY x.user_id, x.weight, x.workout_set_id, x.exercise_id
        	ORDER BY x.weight DESC)
        
        SELECT workouts.*, result_set.weight, result_set.workout_set_id, result_set.exercise_id
        FROM workouts, result_set
        WHERE workouts.id = result_set.workout_id")
  end
end
