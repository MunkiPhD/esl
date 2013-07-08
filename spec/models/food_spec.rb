require 'spec_helper'

describe Food do
  describe "validations" do
    it "has a name" do
      f = Food.new(name: nil)
      expect(f).to have(1).errors_on(:name)
    end

    it "has a name with at least two characters" do
      f = Food.new(name: "A")
      expect(f).to have(1).errors_on(:name)

      f.name = "AB"
      expect(f).to have(0).errors_on(:name)
    end

    it "has a name less than 150 characters" do
      f = Food.new(name: ("A"*151))
      expect(f).to have(1).errors_on(:name)

      f.name = ("A" * 150)
      expect(f).to have(0).errors_on(:name)
    end

    it "has a serving size that is not empty" do
      f = Food.new(serving_size: "")
      expect(f).to have(1).errors_on(:serving_size)
    end

    it "has a serving size less than 75 characters" do
      f = Food.new(serving_size: ("A" * 75))
      expect(f).to have(0).errors_on(:serving_size)

      f.serving_size = ("A" * 76)
      expect(f).to have(1).errors_on(:serving_size)
    end
  end
end
