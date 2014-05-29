# == Schema Information
#
# Table name: exercise_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class ExerciseType < ActiveRecord::Base
	include NiceUrl

	validates :name, presence: true, null: false
end
