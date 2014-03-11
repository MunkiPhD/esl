class HomeController < ApplicationController
  def index
    if current_user
      @memberships = Circle.memberships_for_user(current_user)
    end 
  end
end
