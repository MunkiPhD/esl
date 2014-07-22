require 'rails_helper'

feature 'drilling down on body measurements' do
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


	scenario 'when viewing a specific measurement, only entries where that measurement point is not null is displayed' do
		Timecop.freeze(Date.today) do
			for i in 1..5 do
				create(:body_measurement, user: user, log_date: Date.today - i, chest: nil)
			end

			body_measurement = create(:body_measurement, user: user, log_date: Date.today)
			visit body_measurement_path
			click_link "Chest"
			expect(find(".entry").count).to eq 1
		end
	end


	scenario 'clicking on a measurement point displays a graph and the last ten measurements with that point' do
		body_measurement = create(:body_measurement, user: user)
		visit body_measurement_path(body_measurement)

		for i in 0..11 do
			create(:body_measurement, user: user)
		end

		click_link "Chest"

		expect(page).to have_content("Chest Size")
		expect(find(".measurement").count).to eq 10
	end
end
