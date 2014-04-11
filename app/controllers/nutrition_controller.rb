class NutritionController < ApplicationController
  before_filter :authenticate_user!

  def index
    @logged_foods = current_user.log_foods
  end
end
