class ChangeWorkoutSetTemplatesToAllowNull < ActiveRecord::Migration
  def change
	  change_column_null :workout_set_templates, :weight, true
  end
end
