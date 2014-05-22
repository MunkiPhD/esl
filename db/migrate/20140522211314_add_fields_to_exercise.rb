class AddFieldsToExercise < ActiveRecord::Migration
  def change
		add_column :exercises, :alternate_name, :string
		add_column :exercises, :exercise_type_id, :integer, null: false
		add_column :exercises, :equipment_id, :integer, null: false
		add_column :exercises, :mechanic_type_id, :integer, null: false
		add_column :exercises, :force_type_id, :integer, null: false
		add_column :exercises, :experience_level_id, :integer, null: false
		add_column :exercises, :instructions, :text, default: ''

		add_index :exercises, :exercise_type_id
		add_index :exercises, :equipment_id
		add_index :exercises, :mechanic_type_id
		add_index :exercises, :force_type_id
		add_index :exercises, :experience_level_id
  end
end
