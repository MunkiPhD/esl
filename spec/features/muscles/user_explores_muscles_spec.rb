require 'spec_helper'

feature 'User navigates muscles' do
	scenario 'visits the muscle page and sees the list of muscles' do
		visit muscles_path

		expect(page).to have_content 'Muscles'
		%w(Abdominals Abductors Adductors Biceps Calves Chest Forearms Glutes Hamstrings Lats Neck Quadriceps Shoulders Traps Triceps).each do |muscle|
		expect(page).to have_link muscle
		end
		expect(page).to have_link 'Lower Back'
		expect(page).to have_link 'Middle Back'
	end

	scenario 'clicks on a muscle link and is show the exercises with that muscle' do
		visit muscles_path
		click_link 'Abdominals'

		# a sample of exercises on the page
		expect(page).to have_link '3/4 Sit-Up'
		expect(page).to have_link 'Bent Press'
	end
end
