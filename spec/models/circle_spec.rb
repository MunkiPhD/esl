require 'spec_helper'
require 'cancan/matchers'

describe Circle do
  it "has a valid factory" do
    expect(build(:circle)).to be_valid
  end

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

  describe "abilties" do
    # let(:user) { create(:user) }
    # let(:circle) { create(:circle, user: user) }

    it "assigns admin rights to creator of circle after create" do
      user = create(:user)
      circle = build(:circle, user: user)
      expect(user.has_role? :circle_admin, circle).to eq false

      circle.save
      circle.reload
      expect(user.has_role? :circle_admin, circle).to eq true
    end

    describe "upon joining" do
      it "grants circle_member rights" do
        user = create(:user)
        circle = build(:circle)
        expect(user.has_role? :circle_member, circle).to eq false

        circle.add_member(user)
        expect(user.has_role? :circle_member, circle).to eq true
      end

      it "can leave circle" do
        pending
      end
    end

    describe "permissions" do
      subject { ability }
      let(:user) { create(:user) }
      let(:circle) { create(:circle) }
      let(:ability) { Ability.new(user) }

      describe "circle_admin" do
        before :each do
          circle.add_admin(user)
        end

        context "is allowed to" do
          it { should be_able_to :read, circle }
          it { should be_able_to :edit, circle }
          it { should be_able_to :update, circle }
          it { should be_able_to :destroy, circle }
        end

        context "is not allowed to" do
          pending "admin should be able to do everything"
        end
      end

      describe "circle_member" do
        before :each do
          circle.add_member(user)
        end

        context "is allowed" do
          it { should be_able_to :read, circle }
          it { should be_able_to :leave, circle }
        end

        context "is not allowed to" do
          it { should_not be_able_to :edit, circle }
          it { should_not be_able_to :destroy, circle }
          it { should_not be_able_to :update, circle }
        end
      end
    end
  end

end
