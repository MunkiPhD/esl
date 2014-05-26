module ExerciseSearchHelper
	def was_checked(key, instance)
		if params.has_key?(key)
			params[key].include?(instance.id.to_s) ? true : false
		else
			return false
		end
	end
end
