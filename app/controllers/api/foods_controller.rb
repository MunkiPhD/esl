class API::FoodsController < ApplicationController
	before_filter :authenticate_user!

	def search
		@search_phrase = params[:search] ||= nil
		@page = params[:page] ||= 1
		@results = Food.search_for(@search_phrase).paginate(page: @page, per_page: 25)
	end

	def show
      @food = Food.find(params[:id])
	end
end
