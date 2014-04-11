class LogFoodsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def index
  end

  def show
  end

  def new
    food_id = params[:food_id].to_i
    food = Food.find(food_id)
    @logged_food = LogFood.new(food: food)
  end

  def create
    food = Food.find(logged_food_params[:food_id])
    @logged_food = current_user.log_foods.build(logged_food_params)
    @logged_food.food = food
    
    respond_to do |format|
      if @logged_food.save
        format.html { redirect_to index, notice: "Logged #{@logged_food.servings} servings of #{@logged_food.food_name}" }
      else
        format.html { render action: 'new' }
      end
    end

  end

  def edit
  end

  private 
  def logged_food_params
    params.require(:log_food).permit(:servings, :log_date, :food_id)
  end
end
