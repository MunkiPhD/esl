class AddMainMuscleToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :muscle_id, :integer
		add_index :exercises, :muscle_id	
  end
end
