class CreateWorkoutExercises < ActiveRecord::Migration
  def change
    create_table :workout_exercises do |t|
      t.references :workout, index: true, null: false
      t.references :exercise, index: true, null: false
    end

    change_table :workout_sets do |t|
      t.references :workout_exercise, null: false
    end
  end
end
