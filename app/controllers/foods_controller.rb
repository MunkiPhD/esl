class FoodsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :search]
  before_action :set_food, only: [:show, :edit, :update, :destroy]

  def search
    @search_phrase = params[:search] ||= nil
    @results = Food.search_for(@search_phrase)
  end

  def show
    @favorite_food = FavoriteFood.for_food(@food).first
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
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
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: "Food successfully updated!"}
        format.json { head :no_content}
      else
        format.html { render action: 'edit' }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:food).permit(:name, 
                                   :brand,
                                   :serving_size,
                                   :calories, 
                                   :calories_from_fat,
                                   :total_fat,
                                   :saturated_fat,
                                   :trans_fat,
                                   :polyunsaturated_fat,
                                   :monounsaturated_fat,
                                   :cholesterol,
                                   :sodium,
                                   :carbs,
                                   :dietary_fiber,
                                   :sugars,
                                   :protein,
                                   :vitamin_a,
                                   :vitamin_c,
                                   :calcium,
                                   :iron,
                                   :vitamin_d,
                                   :vitamin_e,
                                   :vitamin_k,
                                   :thiamin,
                                   :riboflavin,
                                   :niacin,
                                   :vitamin_b6,
                                   :biotin,
                                   :pantothenic_acid,
                                   :phosphorus,
                                   :iodine,
                                   :magnesium,
                                   :zinc,
                                   :selenium,
                                   :copper,
                                   :manganese,
                                   :chromium,
                                   :molybednum,
                                   :caffeine,
                                   :alcohol,
                                   :potassium,
                                   :folic_acid,
                                   :boron,
                                   :cobalt,
                                   :fluoride,
                                   :acetic_acid,
                                   :citric_acid,
                                   :lactic_acid,
                                   :malic_acid,
                                   :choline,
                                   :taurine,
                                   :glutamine,
                                   :creatine,
                                   :sugar_alcohols,
                                   :chloride)
    end
end
