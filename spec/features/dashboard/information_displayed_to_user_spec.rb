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

	scenario 'where the user has age, height, and weight it shows the BMI' do
		user.age = 20
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
