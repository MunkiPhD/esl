class API::FoodsController < ApplicationController
	before_filter :authenticate_user!

	def search
	end
end
