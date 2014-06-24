# == Schema Information
#
# Table name: workout_set_templates
#
#  id                           :integer          not null, primary key
#  set_number                   :integer          not null
#  rep_count                    :integer          not null
#  weight                       :integer          not null
#  notes                        :string(255)      default(""), not null
#  is_percent_of_one_rep_max    :boolean          default(FALSE), not null
#  percent_of_one_rep_max       :integer          default(0), not null
#  workout_exercise_template_id :integer          not null
#  created_at                   :datetime
#  updated_at                   :datetime
#

FactoryGirl.define do
	factory :workout_set_template do
		set_number 1
		rep_count 1
		weight 300
		notes ""
		#workout_exercise_template
		#workout_template
		exercise
		is_percent_of_one_rep_max		false
		percent_of_one_rep_max			0
	end

	factory :workout_set_template_with_percent, class: WorkoutSetTemplate do
		set_number 1
		rep_count 1
		weight 300
		notes ""
		#workout_exercise_template
		#workout_template
		exercise

		is_percent_of_one_rep_max	true
		percent_of_one_rep_max		85	
	end
end
