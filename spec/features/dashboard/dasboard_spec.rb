require 'rails_helper'

feature 'dasboard' do
	let(:user) { create(:user) }
	before :each do
		login_user user
	end

	scenario 'is accessible by clicking dashboard on the naviation' do
		visit nutrition_path
		click_link "dashboard"
		expect(page).to have_content "Dashboard"
	end

	scenario 'has the ability to search for food items' do
		visit root_path
		food = create(:food, name: "beef")

		within("#nutrition_search_box") do
			fill_in 'search', with: "beef"
			click_button "Search"
		end

		expect(page).to have_link "beef"
	end

	scenario 'displays the link to log a workout' do
		fail	
	end
end
