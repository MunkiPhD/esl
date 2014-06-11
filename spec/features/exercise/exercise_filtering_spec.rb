require 'rails_helper'

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

	scenario 'can filter by force type' do
		force_type = create(:force_type)
		exercise = create(:exercise, force_type: force_type)
		exercise_excluded = create(:exercise)

		visit exercises_path
		check(force_type.name)
		click_button 'Filter'

		expect(page).to have_link exercise.name
		expect(page).to_not have_link exercise_excluded.name
	end

	scenario 'can filter by experience level' do
		experience_level = create(:experience_level)
		exercise = create(:exercise, experience_level: experience_level)
		exercise_excluded = create(:exercise)

		visit exercises_path
		check(experience_level.name)
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
