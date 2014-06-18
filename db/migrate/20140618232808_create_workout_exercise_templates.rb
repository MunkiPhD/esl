class CreateWorkoutExerciseTemplates < ActiveRecord::Migration
  def change
    create_table :workout_exercise_templates do |t|
      t.references :workout_template, index: true, null: false
      t.references :exercise, index: true, null: false
    end
  end
end
