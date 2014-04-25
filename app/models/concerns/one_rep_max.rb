module OneRepMax
	def self.epley_formula(weight, reps)
		weight.to_f * (1 + (reps.to_f / 30))
	end
	
	def self.brzycki_formula(weight, reps)
		weight.to_f * (36 / (37-reps.to_f))
	end
end
