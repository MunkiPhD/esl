class FoodsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :search]
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  def search
    @search_phrase = params[:search] ||= nil
  end

  def show
  end

  def new
    @food = Food.new
  end

  def create
    @food = foods.build(food_params)
    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render action: 'show', status: :created, location: @food }
      else
        format.html { render action: 'new' }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  
  private
    def set_food
      @food = Food.find_by_param(params[:id])
    end

    def food_params
      #params.require(:food).permit()
      # this needs to be based off of the list of whitelisted attributes (which is a lot...)
      # but for now, we're just going to return the params list
      params.require(:food)
    end
end
