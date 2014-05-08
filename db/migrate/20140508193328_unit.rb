class Unit < ActiveRecord::Migration
  def change
	 create_table :units do |t| 
		t.integer :unit_type, null: false
		t.string :unit_type_name, null: false
		t.integer :unit_system, null: false
		t.string :unit_system_name, null: false
		t.string :unit_name, null: false
		t.string :unit_abbr, null: false
	 end
  end
end
