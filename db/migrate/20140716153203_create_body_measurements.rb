class CreateBodyMeasurements < ActiveRecord::Migration
  def change
    create_table :body_measurements do |t|
      t.date :log_date, null: false, default: Date.today

      t.decimal :bicep, precision: 5, scale: 2
      t.decimal :calf, precision: 5, scale: 2
      t.decimal :chest, precision: 5, scale: 2
      t.decimal :forearm, precision: 5, scale: 2
      t.decimal :hips, precision: 5, scale: 2
      t.decimal :neck, precision: 5, scale: 2
      t.decimal :thigh, precision: 5, scale: 2
      t.decimal :waist, precision: 5, scale: 2

		t.references :unit, null: false, default: 0
		t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
