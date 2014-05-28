module ExerciseFilters
	extend ActiveSupport::Concern

	included do
		def self.for_exercise_type(exercise_type)
			where(exercise_type: exercise_type)
		end

		def self.for_equipment(equipment)
			where(equipment: equipment)
		end

		def self.for_mechanic_type(mechanic_type)
			where(mechanic_type: mechanic_type)
		end

		def self.for_muscle(muscle)
			where(muscle: muscle)
		end

		def self.for_force_type(force_type)
			where(force_type: force_type)
		end

		def self.for_experience_level(experience_level)
			where(experience_level: experience_level)
		end
	end
end
