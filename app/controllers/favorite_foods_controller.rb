class FavoriteFoodsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @favorite_foods = current_user.favorite_foods
  end

  def create
    favorite_food = current_user.favorite_foods.build(food_id: params[:id])
    respond_to do |format|
      favorite_food.save
      flash[:success] = "#{favorite_food.food_name} was added to your favorites"
      format.html { redirect_to nutrition_path }
    end
  end


  def destroy
    @favorite_food = current_user.favorite_foods.find(params[:id])
    flash[:success] = "#{@favorite_food.food_name} was removed from your favorites"
    @favorite_food.destroy

    respond_to do |format|
      format.html { redirect_to favorite_foods_path }
    end
  end
end
