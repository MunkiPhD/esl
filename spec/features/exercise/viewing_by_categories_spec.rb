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


	scenario 'clicking on equipment for an exercise shows the exercises that use that equipment' do
		equipment = create(:equipment, name: "my equipment")
		exercise = create(:exercise, equipment: equipment)
		exercise_two = create(:exercise)

		visit exercise_path(exercise)
		click_link exercise.equipment_name
		expect(page).to have_content "Equipment: #{equipment.name}"
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


	scenario 'clicking on a mechanic type on the exercise page shows exercises with that same mechanic type' do
		mechanic_type = create(:mechanic_type)
		exercise = create(:exercise, mechanic_type: mechanic_type)
		exercise_excluded = create(:exercise)

		visit exercise_path(exercise)
		click_link exercise.mechanic_type_name

		expect(page).to have_content "Mechanic Type: #{mechanic_type.name}"
		expect(page).to have_link exercise.name
		expect(page).to_not have_link exercise_excluded.name
	end
end
