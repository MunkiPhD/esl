class FavoriteFoodsController < ApplicationController
  def index
    @favorite_foods = current_user.favorite_foods.all
  end


  def new
  end

  def create
    favorite_food = current_user.favorite_foods.build(food_id: params[:id])
    respond_to do |format|
      favorite_food.save
      flash[:success] = "#{favorite_food.food_name} was added to your favorites"
      format.html { redirect_to nutrition_path }
    end
  end
end
