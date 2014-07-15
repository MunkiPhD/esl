require 'rails_helper.rb'

feature 'user manages their body measurements' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'can log a single body measurement' do
		visit root_path
		click_link "Body Measurements"

		click_link "Record Measurements"

		fill_in "Chest", with: "53"

		click_button "Save Measurements"
		expect(page).to have_content "Body measurements saved."
		expect(page).to have_content "Chest: 53 in." 
		expect(page).to have_content "Arms: not measured"
	end


	scenario 'by recording multiple points of measurement data' do
		visit body_measurements_path
		click_link 'Record Measurements'

		fill_in 'Thighs', with: '47'
		fill_in 'Neck', with: '17'

		click_button 'Save Measurements'

		expect(page).to have_content 'Thighs: 47 in.'
		expect(page).to have_content 'Neck: 17 in.'
	end


	scenario 'can edit existing measurement data' do
		body_measurement = create(:body_measurement, user: user)
		visit body_measurement_path(body_measurement)

		expected_str = "Chest: #{body_measurement.chest} in."
		expect(page).to have_content expected_str

		click_link "Edit"

		new_measurement = "#{body_measurement.chest + 1}.0"
		fill_in "Chest", with: new_measurement

		click_button "Save Measurements"

		expect(page).to have_content  "Body measurements were updated."
		expect(page).to have_content ("Chest: " + new_measurement + " in.")
	end


	scenario 'can delete an existing body measurements entry' do
		body_measurement = create(:body_measurement, user: user)
		visit body_measurement_path(body_measurement)

		expect {
			click_button "Delete"
		}.to change(BodyMeasurements, :count).by(-1)

		expect(page).to have_content "Body measurements entry was deleted."
	end


	scenario 'defaults to the current date when creating a new entry point' do
		visit body_measurements_path
		Timecop.freeze(Date.today) do
			click_link "Record Measurements"
			expect(find("#log_date").value).to eq "#{Date.today.strftime('%d-%B-%Y')}"
		end
	end

	scenario 'clicking on a measurement point displays a graph and the last ten measurements with that point' do
		body_measurement create(:body_measurement, user: user)
		visit body_measurement_path(body_measurement)

		for i in 0..11 do
			create(:body_measurement, user: user)
		end

		click_link "Chest"

		expect(page).to have_content("Chest Size")
		expect(find(".measurement").count).to eq 10
	end

	scenario 'user can navigate to the body measurement from each individual mesurement point' do
		Timecop.freeze(Date.today) do
			body_measurement = create(:body_measurement, user: user, log_date: Date.today)
			body_measurement_yesterday = create(:body_measurement, user: user, log_date: Date.yesterday)

			visit body_measurement_path(body_measurement)

			click_link "Chest"
			expect(page).to have_content "#{Date.today.strftime('%d-%B-%Y')}"

			find("a.measurement")[1].click

			expect(page).to have_content "#{Date.yesterday.strftime('%d-%B-%Y')}"
		end
	end

	scenario 'the unit for the measurement is the same as the user preferences' do
		fail		
	end
end
