class LogFoodsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @food = Food.find_by_param(params[:food_id])
    @logged_foods = current_user.log_foods.for_food(@food)
  end

  def show
    @logged_food = current_user.log_foods.find(params[:id].to_i)
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
    @logged_food = current_user.log_foods.find(params[:id].to_i)
  end

  def update
    @logged_food = current_user.log_foods.find(params[:id])

    respond_to do |format|
      if @logged_food.nil?
        format.html { redirect_to nutrition_path, notice: "You cannot edit an item that does not belong to you!" }
        format.json { head :no_content }
      end

      if @logged_food.update(logged_food_params)
        format.html { redirect_to nutrition_path, notice: "Successfully updated food log entry!" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @logged_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @logged_food = current_user.log_foods.find(params[:id].to_i)
    respond_to do |format|
      if @logged_food.user != current_user
        format.html { redirect_to nutrition_path, error: "You cannot delete an entry that does not belong to you" }
        format.json { head :no_content }
      else
        if @logged_food.destroy
          format.html { redirect_to nutrition_path, notice: "Food log entry deleted." }
          format.json { head :no_content }
        else
          format.html { redirect_to nutrition_path, error: "Could not delete the entry." }
          format.json { render json: @logged_food.errors, status: :unprocessable_entity }
        end
      end

      
    end 
  end

  private 
  def logged_food_params
    params.require(:log_food).permit(:servings, :log_date, :food_id)
  end
end
