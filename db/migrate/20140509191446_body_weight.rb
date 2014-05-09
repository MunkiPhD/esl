class BodyWeight < ActiveRecord::Migration
	def change
		create_table :body_weights do |t|
			t.date :log_date, null: false, default: Date.today
			t.decimal :weight, null: false, scale: 6, precision: 9
			t.references :unit, null: false
			t.references :user, null: false, index: true

			t.timestamps
		end
	end
end
