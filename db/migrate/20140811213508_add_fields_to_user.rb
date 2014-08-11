class AddFieldsToUser < ActiveRecord::Migration
  def change
	  add_column :users, :height, :decimal, scale: 2, precision: 4, null: true
	  add_column :users, :gender, :integer, limit: 3, null: false, default: 0
	  add_column :users, :birth_date, :datetime, null: true
  end
end
