class ExperienceLevelsController < ApplicationController
	def show
		@experience_level = ExperienceLevel.find(params[:id])
		@exercises = Exercise.for_experience_level(@experience_level)
	end
end
