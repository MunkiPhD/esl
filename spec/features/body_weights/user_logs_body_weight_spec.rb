require 'spec_helper'

feature 'User manages their body weight stats' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'can visit entries from link section' do
		visit root_path
		click_link 'body weight'
		expect(page).to have_content 'Body Weight'
	end

	scenario 'logs an entry' do
		date = Date.today
		visit_and_log_entry(200, date)
	end

	scenario 'logs an entry for a date a week ago' do
		date = 1.week.ago
		visit_and_log_entry(100, date)
	end

	scenario 'edits an entry' do
		Timecop.freeze(Date.today) do
			visit_and_log_entry(200, Date.today)
			within '#body_weight_entries' do
				click_link 'Edit'
			end
			expect(page).to have_content "Editing body weight entry"

			week_ago = 1.week.ago
			within 'form.edit_body_weight' do
				fill_in "Weight", with: 175
				select_log_date(week_ago, 'body_weight_log_date')
				click_button 'Save'
			end

			expect(page).to have_content "Entry updated"
			within '#body_weight_entries' do
				expect(page).to have_content '175'
				expect(page).to have_content format_date(week_ago)
				expect(page).to_not have_content '200'
				expect(page).to_not have_content format_date(Date.today)
			end
		end
	end

	scenario 'deletes an entry' do
		date = Date.today
		visit_and_log_entry(200, date)
		within '#body_weight_entries' do
			click_button 'Delete'
		end
		within '#body_weight_entries' do
			expect(page).to_not have_content format_date(date)
			expect(page).to_not have_content '200'
		end
		expect(page).to have_content "Entry deleted"
	end

	def visit_and_log_entry(weight, date)
		Timecop.freeze(Date.today) do
			visit body_weights_path
			expect(page).to have_content 'Body Weight'

			within '#body_weight_entries' do
				expect(page).to_not have_content weight
			end

			within '#new_body_weight' do
				fill_in "Weight", with: weight
				select_log_date(date, 'body_weight_log_date')
				click_button 'Save'
			end

			expect(page).to have_content "Body Weight entry logged!"
			within '#body_weight_entries' do
				date_str = date.strftime('%d-%B-%Y')
				expect(page).to have_content weight
				expect(page).to have_content date_str
			end
		end
	end
end
