class BodyWeightsController < ApplicationController
	def index
		@body_weight = BodyWeight.new
	end
end
