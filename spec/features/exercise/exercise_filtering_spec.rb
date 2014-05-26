require 'spec_helper'

feature 'viewers can filter the exercise list by categories' do
	scenario 'can filter by equipment type' do
		equipment = create(:equipment)
		exercise = create(:exercise, equipment: equipment)
		exercise_excluded = create(:exercise)

		visit exercises_path
		check(equipment.name)
		click_button 'Filter'

		expect(page).to have_link exercise.name
		expect(page).to_not have_link exercise_excluded.name
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
