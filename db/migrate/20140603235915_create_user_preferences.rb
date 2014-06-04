class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
			t.references :user, null: false
			t.integer :default_system_id, null: false, default: Unit.unit_systems[:us_system]

      t.timestamps
    end

		add_index :user_preferences, :user_id
  end
end
