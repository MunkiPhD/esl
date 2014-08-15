class RenameBodyMeasurementColumnsAndAddNewOnes < ActiveRecord::Migration
	change_table :body_measurements do |t|
	  t.rename :bicep, :bicep_right
	  t.rename :calf, :calf_right
	  t.rename :forearm, :forearm_right
	  t.rename :thigh, :thigh_right

	  t.decimal :bicep_left, precision: 5, scale: 2
	  t.decimal :calf_left, precision: 5, scale: 2
	  t.decimal :forearm_left, precision: 5, scale: 2
	  t.decimal :thigh_left, precision: 5, scale: 2
  end
end
