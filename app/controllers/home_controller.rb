class HomeController < ApplicationController
  def index
    if current_user
      @memberships = Circle.memberships_for_user(current_user)
		@weight_entry_count = current_user.body_weights.count
		@presenter = Nutrition::DashboardPresenter.new(current_user, Date.today)
    end 
  end
end
