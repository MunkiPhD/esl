class API::FoodsController < ApplicationController
	before_filter :authenticate_user!

	def search
		@search_phrase = params[:search] ||= nil
		@results = Food.search_for(@search_phrase).paginate(page: params[:page], per_page: 25)
	end
end
