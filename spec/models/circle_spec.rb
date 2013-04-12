require 'spec_helper'

describe Circle do
  it "has a unique name" do
    create(:circle, name: "group1")
    circle = build(:circle, name: "group1")
    expect(circle).to have(1).errors_on(:name)
  end

  it "has a name at least 3 charcters long" do
    circle = Circle.new(name: nil)
    expect(circle).to have(2).errors_on(:name)
    
    circle = Circle.new(name: "22")
    expect(circle).to have(1).errors_on(:name)

    circle = Circle.new(name: "222")
    expect(circle).to have(0).errors_on(:name)
  end

  it "has a name shorter than 120 characters long" do
    circle = Circle.new(name: "a" * 121)
    expect(circle).to have(1).errors_on(:name)
  end

  it "has a description that can be empty" do
    circle = Circle.new(description: "")
    expect(circle).to have(0).errors_on(:description)
  end

  it "must be created by a user" do
    circle = Circle.new(user: nil)
    expect(circle).to have(1).errors_on(:user)
  end

  it "has a motto shorter than 50 characters" do
    circle = Circle.new(motto: "a" * 51)
    expect(circle).to have(1).errors_on(:user)
  end

  it "must have a value for if it's public" do
    circle = Circle.new(is_public: nil)
    expect(circle).to have(1).errors_on(:is_public)
  end
end
