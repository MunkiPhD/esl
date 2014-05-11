require 'spec_helper'

feature 'Visitor manages body weight' do
	scenario 'attempts to visit page but is redirected' do
			visit body_weights_path
			expect(page).to have_content "You need to sign in"
	end
end
