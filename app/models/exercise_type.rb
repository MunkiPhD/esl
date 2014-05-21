class ExerciseType < ActiveRecord::Base
	validates :name, presence: true, null: false
end
