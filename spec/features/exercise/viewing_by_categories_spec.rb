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

	scenario 'selects to view by muscle and exercise type' do
		muscle = create(:muscle)
		exercise_type = create(:exercise_type)

		exercise = create(:exercise, muscle: muscle, exercise_type: exercise_type)
		exercise_two = create(:exercise, exercise_type: exercise_type)
		exercise_excluded = create(:exercise)

		visit exercises_path
		check(muscle.name)
		check(exercise_type.name)
		click_button 'Filter'

		expect(page).to have_link exercise.name
		expect(page).to_not have_link exercise_two.name
		expect(page).to_not have_link exercise_excluded.name
	end

	scenario 'selects two of the same category' do
		muscle = create(:muscle)
		muscle_two = create(:muscle)

		exercise = create(:exercise, muscle: muscle)
		exercise_two = create(:exercise, muscle: muscle_two)
		exercise_excluded = create(:exercise)

		visit exercises_path

		check(muscle.name)
		check(muscle_two.name)
		
		click_button("Filter")

		expect(page).to have_link exercise.name
		expect(page).to have_link exercise_two.name
		expect(page).to_not have_link exercise_excluded.name
	end
end
