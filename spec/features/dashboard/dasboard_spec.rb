require 'rails_helper'

feature 'dasboard features' do
	let(:user) { create(:user) }
	before :each do
		login_user user
	end

	scenario 'is accessible by clicking dashboard on the naviation' do
		visit nutrition_path
		click_link "dashboard"
		expect(page).to have_content "Dashboard"
	end
end
