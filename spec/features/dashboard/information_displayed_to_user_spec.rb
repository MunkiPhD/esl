require 'rails_helper'

feature 'Information displayed on the dashboard' do
	let(:user) { create(:user) }
	before :each do
		login_user user
	end

	scenario 'where the user does not have age, height, or weight entered, BMI is not displayed' do
		user.birth_date = nil
		user.save!

		visit root_path

		within("#bmi") do
			expect(page).to have_content "not enough information"
		end
	end

	scenario 'where a user does not have birth date, it asks the user to record their birth date' do
		user.birth_date = nil
		user.save!

		visit root_path

		within("#bmi") do
			expect(page).to have_link "Set your age"
		end
	end

	scenario 'where a user does not have a height, it asks the user to record their height' do
		user.height = nil
		user.save!

		visit root_path

		within("#bmi") do
			expect(page).to have_link "Set your height"
		end
	end

	scenario 'when a user does not have a weight, it asks the user to record a weight' do
		expect(user.body_weights.count).to eq 0

		visit root_path

		within("#bmi") do
			expect(page).to have_link "Record your weight"
		end
	end

	scenario 'where the user has age, height, and weight it shows the BMI' do
		user.birth_date = 20.years.ago + 1
		user.height = 70
		user.save

		weight = create(:body_weight, user: user, weight: 200)
		visit root_path

		within("#bmi") do 
			expect(page).to have_content user.bmi
			expect(page).to_not have_content "not enough information"
		end
	end
end
