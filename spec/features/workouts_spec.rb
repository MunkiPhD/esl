require 'spec_helper'

feature "Workouts" do
  scenario "user can add a workout" do
    user = create(:user)
    login_user user
 
    visit workouts_path
    expect(page).to have_content("logout")
  end
end
