class FavoriteFoodsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @favorite_foods = current_user.favorite_foods.includes(:food)
  end

  def create
    favorite_food = current_user.favorite_foods.build(food_id: params[:id])
    respond_to do |format|
      favorite_food.save
      flash[:success] = "#{favorite_food.food_name} was added to your favorites"
      format.html { redirect_to food_path(favorite_food.food) }
    end
  end


  def destroy
    favorite_food = current_user.favorite_foods.find(params[:id])
    food = favorite_food.food
    flash[:success] = "#{food.name} was removed from your favorites"
    favorite_food.destroy

    respond_to do |format|
      format.html { redirect_to favorite_foods_path }
    end
  end
end
