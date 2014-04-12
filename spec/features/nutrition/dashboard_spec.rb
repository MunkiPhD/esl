require 'spec_helper'

feature "user visits the dashboard" do
  context 'valid user' do
    let(:user) { create(:user) }

    before :each do
      login_user user
    end

    scenario 'user access the nutrition dashboard from the main screen and sees no logged foods for the day' do
      visit root_path
      click_link "nutrition"
      expect(page).to have_content "Nutrition Dashboard"
      expect(page).to have_content "No foods logged yet for today!"
    end

    scenario 'elects to view a different date and sees different logged foods' do
      logged_food = create(:log_food, user: user, log_date: Date.today)
      visit root_path
      click_link "nutrition"
      expect(page).to have_content logged_food.food_name
      within '#selected_date' do
        expect(page).to have_content "Today"
      end

      date = Date.yesterday
      select date.day.to_s, from: 'log_date_day'
      select date.strftime("%B"), from: 'log_date_month'
      select date.year.to_s, from: 'log_date_year'
      click_button 'Go'


      expect(page).to have_content "1 day ago"
      expect(page).to have_link "Go back to today"
      expect(page).to_not have_content logged_food.food_name


      # go back to a date in a previous year
      date = 2.years.ago
      select date.day.to_s, from: 'log_date_day'
      select date.strftime("%B"), from: 'log_date_month'
      select date.year.to_s, from: 'log_date_year'
      click_button 'Go'
      expect(page).to have_content "about 2 years ago"
      expect(page).to have_link "Go back to today"
    end
  end
end