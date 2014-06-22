require 'rails_helper'

feature 'User can manage workout templates' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'can view a list of all their templates' do
		template = create(:workout_template, user: user)
		visit workout_templates_path
		expect(page).to have_content template.title
	end
	
end
