require 'rails_helper.rb'

feature 'user manages their body measurements' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'can log a single body measurement' do
		visit root_path
		click_link "measure"

		click_link "Record Measurements"

		fill_in "Chest", with: "53"

		click_button "Save Measurements"
		expect(page).to have_content "Body measurements saved."
		expect(page).to have_content "Chest: 53.0 in" 
		expect(page).to have_content "Bicep: not measured"
	end


	scenario 'by recording multiple points of measurement data' do
		visit body_measurements_path
		click_link 'Record Measurements'

		fill_in 'Bicep', with: '2'
		fill_in 'Calf', with: '3'
		fill_in 'Chest', with: '4'
		fill_in 'Forearm', with: '6'
		fill_in 'Hips', with: '7'
		fill_in 'Neck', with: '8.1'
		fill_in 'Thigh', with: '9'
		fill_in 'Waist', with: '10'

		click_button 'Save Measurements'

		expect(page).to have_content 'Bicep: 2.0 in'
		expect(page).to have_content 'Calf: 3.0 in'
		expect(page).to have_content 'Chest: 4.0 in'
		expect(page).to have_content 'Forearm: 6.0 in'
		expect(page).to have_content 'Hips: 7.0 in'
		expect(page).to have_content 'Neck: 8.1 in'
		expect(page).to have_content 'Thigh: 9.0 in'
		expect(page).to have_content 'Waist: 10.0 in'
	end

	scenario 'can view all logged entries from the index page' do
		bm = create(:body_measurement, user: user)
		visit body_measurements_path
		expect(page).to have_link format_date(bm.log_date)
	end

	scenario 'can edit existing measurement data' do
		body_measurement = create(:body_measurement, chest: 52, user: user)
		visit body_measurement_path(body_measurement)

		expected_str = "Chest: #{body_measurement.chest} in"
		expect(page).to have_content expected_str

		click_link "Edit"

		fill_in "Chest", with: "53"

		click_button "Save Measurements"

		expect(page).to have_content  "Body measurements entry was updated."
		expect(page).to have_content ("Chest: 53.0 in")
	end


	scenario 'can delete an existing body measurements entry' do
		body_measurement = create(:body_measurement, user: user)
		visit body_measurement_path(body_measurement)

		expect {
			click_button "Delete"
		}.to change(BodyMeasurement, :count).by(-1)

		expect(page).to have_content "Body measurement entry was deleted."
	end


	scenario 'defaults to the current date when creating a new entry point' do
		visit body_measurements_path
		Timecop.freeze(Date.today) do
			click_link "Record Measurements"
			expect(find("#body_measurement_log_date_3i").value).to eq "#{Date.today.strftime('%-d')}"
			expect(find("#body_measurement_log_date_2i").value).to eq "#{Date.today.strftime('%B')}"
			expect(find("#body_measurement_log_date_1i").value).to eq "#{Date.today.strftime('%Y')}"
		end
	end


	scenario 'the unit for the measurement is the same as the user preferences when logging an entry' do
		preferences = create(:user_preferences_metric, user: user)
		visit new_body_measurement_path
		saves_metric_measurements
	end

	scenario 'if the user changes their preferences for unit, the entries under a previous unit do not change' do
		preferences = create(:user_preferences_metric, user: user)
		visit new_body_measurement_path
		saves_metric_measurements
		preferences.default_system_id = 0
		preferences.save

		visit body_measurement_path(BodyMeasurement.last)

		expect(page).to have_content 'Thigh: 9.0 cm'
		expect(page).to have_content 'Waist: 10.0 cm'
	end

	def saves_metric_measurements
		expect(page).to have_content "Logging Body Measurements"
		all(".measurement-unit").each do |entry|
			expect(entry).to have_content "cm"	
			expect(entry).to_not have_content "in"	
		end

		fill_in 'Thigh', with: '9'
		fill_in 'Waist', with: '10'

		click_button 'Save Measurements'

		expect(page).to have_content 'Thigh: 9.0 cm'
		expect(page).to have_content 'Waist: 10.0 cm'
	end
end
