require 'spec_helper'

feature 'can view the exercises by category' do
	scenario 'clicking an exercise type on an exercise shows the exercises with that specified type' do
		type = create(:exercise_type, name: "one")
		exercise = create(:exercise, exercise_type: type)
		exercise_two = create(:exercise, exercise_type: create(:exercise_type, name: "two"))

		visit exercise_path(exercise)
		click_link exercise.exercise_type_name
		expect(page).to have_content "Exercise Type: #{type.name}"
		expect(page).to have_link exercise.name
		expect(page).to_not have_link exercise_two.name
	end

	scenario 'clicking a muscle name on the exercise page shows exercises with that muscle' do
		exercise = create(:exercise)
		visit exercise_path(exercise)
		click_link exercise.muscle_name

		expect(page).to have_content exercise.muscle_name
		expect(page).to have_link exercise.name
	end
end
