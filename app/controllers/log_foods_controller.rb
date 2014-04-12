class LogFoodsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @logged_foods = LogFood.all
  end

  def show
  end

  def new
    @logged_food = LogFood.new(log_date: Date.today)
    food_id = params[:food_id].to_i
    @logged_food.food = Food.find(food_id)
  end

  def create
    @logged_food = current_user.log_foods.build(logged_food_params)
    
    respond_to do |format|
      if @logged_food.save
        format.html { redirect_to nutrition_path, notice: "Logged #{@logged_food.servings} servings of #{@logged_food.food_name}" }
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
