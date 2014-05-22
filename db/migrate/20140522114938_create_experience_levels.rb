class CreateExperienceLevels < ActiveRecord::Migration
  def change
    create_table :experience_levels do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
