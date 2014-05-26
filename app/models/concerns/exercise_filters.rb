module ExerciseFilters
	extend ActiveSupport::Concern

	included do
		[:exercise_type, :equipment, :mechanic_type].each do |method|
			define_singleton_method "for_#{method}" do |argument|
				where("exercises.#{method}_id = ?", argument)
			end
		end

		def self.with_main_muscle(muscle)
			where(muscle: muscle)
		end
	end
end
