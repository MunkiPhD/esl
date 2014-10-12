class HomeController < ApplicationController
  def index
    if current_user
		@todays_date = Date.today	
      @memberships = Circle.memberships_for_user(current_user)
		@weight_entry_count = current_user.body_weights.count
		@workouts = current_user.workouts.on_date(@todays_date)
		@presenter = Nutrition::DashboardPresenter.new(current_user, @todays_date)
    end 
  end
end
