# == Schema Information
#
# Table name: log_foods
#
#  id         :integer          not null, primary key
#  servings   :decimal(, )      default(1.0), not null
#  log_date   :date             default(Thu, 10 Apr 2014), not null
#  food_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe LogFood do
  let(:user) { build(:user) }

  context 'validation' do
    it 'has a valid factory' do
      expect(build(:log_food)).to be_valid
    end

    it 'has a user' do
      logged = LogFood.new(user: user)
      expect(logged).to have(0).errors_on(:user)
    end

    it 'has a food' do
      logged = LogFood.new(food: create(:bread))
      expect(logged).to have(0).errors_on(:food)
    end

    it 'has a date' do
      logged = LogFood.new
      expect(logged).to have(0).errors_on(:log_date)
    end

    it "must have a number greater than 0" do
      logged = LogFood.new(servings: 1.24)
      expect(logged).to have(0).errors_on(:servings)
    end
  end

  context "invalid" do
    it 'has a user' do
      logged = LogFood.new
      expect(logged).to have(1).errors_on(:user)
    end

    it 'has a food' do
      logged = LogFood.new
      expect(logged).to have(1).errors_on(:food)
    end

    it 'has a date' do
      logged = LogFood.new(log_date: "")
      expect(logged).to have(1).errors_on(:log_date)
    end

    it "must have a number greater than 0" do
      logged = LogFood.new(servings: 0)
      expect(logged).to have(1).errors_on(:servings)
    end

    it 'has servings less than 1000' do
      logged = LogFood.new(servings: 1001)
      expect(logged).to have(1).errors_on(:servings)
    end
  end
end
