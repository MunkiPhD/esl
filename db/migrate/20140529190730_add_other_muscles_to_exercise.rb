class AddOtherMusclesToExercise < ActiveRecord::Migration
  def change
	  add_column :exercises, :other_muscles, :string
  end
end
