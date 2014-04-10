require 'spec_helper'

describe LogFood do
  let(:user) { build(:user) }

  context 'validation' do
    it 'has a valid factory' do
      expect(build(:log_food)).to be_valid
    end

    it 'has a user' do
      food = LogFood.new(user: user)
      expect(food).to have(0).errors_on(:user)
    end

    it 'has a food' do
      logged = LogFood.new(food: build(:bread))
      expect(food).to have(0).errors_on(:food)
    end

    it 'has a date' do
      logged = LogFood.new
      expect(logged).to have(0).errors_on(:log_date)
    end

    it "must have a number greater than 0" do
      logged = LogFood.new(servings: 0)
      expect(logged).to have(1).errors_on(:servings)
    end
  end
end
