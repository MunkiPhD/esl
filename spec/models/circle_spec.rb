# == Schema Information
#
# Table name: circles
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  motto       :string(255)      default("")
#  description :text             default(""), not null
#  is_public   :boolean          default(TRUE), not null
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

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

  it "not public is set to false if unchecked" do
    circle = Circle.new(is_public: false)
    expect(circle).to have(0).errors_on(:is_public)
    expect(circle.is_public).to eq false
  end

  describe "abilties" do
    # let(:user) { create(:user) }
    # let(:circle) { create(:circle, user: user) }

    it "assigns admin rights and member rights to creator of circle after create" do
      user = create(:user)
      circle = build(:circle, user: user)
      expect(user.has_role? :admin, circle).to eq false
      expect(user.has_role? :member, circle).to eq false

      circle.save
      circle.reload
      expect(user.has_role? :admin, circle).to eq true
      expect(user.has_role? :member, circle).to eq true
    end

    it "automatically assigns member rights if a user is added as an admin and has no member rights" do
      user = create(:user)
      circle = create(:circle)

      expect(user.has_role? :member, circle).to eq false

      circle.add_admin(user)

      expect(user.has_role? :admin, circle).to eq true
      expect(user.has_role? :member, circle).to eq true
    end

    describe "when circle is destroyed" do
      it "removes the roles from all the members" do
        user = create(:user)
        circle = create(:circle, user: user)
        expect(user.circles.count).to eq 1

        user2 = create(:user)
        circle.add_member(user2)
        expect(user2.has_role? :member, circle).to eq true

        circle.destroy
        expect(user2.has_role? :member, circle).to eq false
        expect(user.circles.count).to eq 0
      end
    end

    describe 'methods' do
      let(:user) { create(:user) }
      let(:circle) { create(:circle) }

      
      describe '#intersecting_groups' do
        let(:user2) { create(:user) }
        let(:circle2) { create(:circle, user: user2) }

        context 'nil users' do
          it 'returns an empty array if user_one is nil' do
           expect(Circle.intersecting_groups(nil, user).empty?).to eq true
          end

          it 'returns an empty array if user_two is nil' do
           expect(Circle.intersecting_groups(user, nil).empty?).to eq true
          end
        end
      
        context 'no groups in common' do
          it 'returns an empty array' do
            common_groups = Circle.intersecting_groups(user, user2)
            expect(common_groups).to eq []
          end

          it 'responds true to empty?' do
            common_groups = Circle.intersecting_groups(user, user2)
            expect(common_groups.empty?).to eq true
          end
        end

        context 'groups in common' do
          before :each do
            random_admin = create(:user)
            @common_circle = create(:circle, user: random_admin)

            @common_circle.add_member user
            @common_circle.add_member user2
            @intersection = Circle.intersecting_groups(user, user2)
          end

          it 'returns the group in common' do
            expect(@intersection).to eq [@common_circle]
          end

          it 'has a count equal to one' do
            expect(@intersection.count).to eq 1 
          end

          it 'has same group if user is the same' do
            intersection = Circle.intersecting_groups(user, user)
            expect(intersection).to eq [@common_circle]
          end
        end
      end


      describe '#pending' do
        it 'returns a list of all users pending membership approval' do
          user2 = create(:user)
          circle.add_pending(user)
          circle.add_pending(user2)

          expect(circle.pending_members).to eq [user, user2]
        end
      end

      describe '#members' do
        it 'returns a list of all users with member role' do
          user2 = create(:user)
          circle2 = create(:circle, user: user)
          circle2.add_member(user)
          circle2.add_member(user2)

          expect(circle2.members).to eq [user, user2]
        end
      end

      describe '#admins' do
        it 'returns a list of all users that are admins' do
          user2 = create(:user)
          circle2 = create(:circle, user: user)
          circle2.add_admin(user)
          circle2.add_admin(user2)

          expect(circle2.admins).to eq [user, user2]
        end
      end

      describe '#request_membership' do
        it 'sets user as pending if the circle is private' do
          private_circle = create(:circle, is_public: false)
          private_circle.request_membership(user)
          expect(private_circle.is_member? user).to eq false
          expect(private_circle.is_pending? user).to eq true
        end

        it 'adds the user as a member if the group is public' do
          circle.request_membership(user)
          expect(circle.is_pending? user).to eq false
          expect(circle.is_member? user).to eq true
        end

        it 'when there are no members makes the first person to join an admin on the circle' do
          circle.members.each { |member| circle.remove_member(member) }
          expect(circle.members.count).to eq 0
          circle.request_membership(user)

          expect(circle.is_member? user).to eq true
          expect(circle.is_admin? user).to eq true
        end
      end

      describe '#approve_membership' do
        it 'approves a user if they were pending' do
          private_circle = create(:circle, is_public: false)
          private_circle.add_pending(user)

          admin = create(:user)
          private_circle.add_admin(admin)

          private_circle.approve_membership(user, admin)
          expect(private_circle.is_member? user).to eq true
        end 
      end

      describe '#is_pending?' do
        it 'returns false when user is not pending' do
          expect(circle.is_pending? user).to eq false
        end

        it 'returns true when a user is pending' do
          circle.add_pending(user)
          expect(circle.is_pending? user).to eq true
        end

        it 'if a user is pending they are not a member' do
          circle.add_pending(user)
          expect(circle.is_member? user).to eq false
        end

        it 'if a user is a member, they can not be pending' do
          circle.add_pending(user)
          expect(circle.is_pending? user).to eq true

          circle.add_member(user)
          expect(circle.is_member? user).to eq true
          expect(circle.is_pending? user).to eq false
        end
      end

      describe '#is_member?' do
        it "returns false when a circle has no members" do
          circle.remove_member(circle.user)
          expect(circle.members.count).to eq 0
          expect(circle.is_member? user).to eq false
        end

        it "returns false when not a member" do
          expect(circle.is_member?(user)).to eq false
        end

        it "returns true if a member" do
          circle.add_member(user)
          expect(circle.is_member?(user)).to eq true
        end
      end

      describe '#is_admin?' do
        it 'returns false for non-admins' do
          expect(circle.is_admin?(user)).to eq false
        end

        it 'returns true if an admin' do
          circle.add_admin(user)
          expect(circle.is_admin? user).to eq true
        end
      end
    end

    describe "when joining" do
      let(:user) { create(:user) }
      it "grants member rights" do
        circle = build(:circle)
        expect(user.has_role? :member, circle).to eq false

        circle.add_member(user)
        expect(user.has_role? :member, circle).to eq true
      end

      it "can leave circle" do
        circle = build(:circle)

        circle.add_member(user)
        expect(user.has_role? :member, circle).to eq true

        circle.remove_member(user)
        expect(user.has_role? :member, circle).to eq false
      end

      it "adds pending rights if circle is not public" do
        circle = create(:circle, is_public: false)
        expect(circle.is_member?(user)).to eq false

        circle.add_pending(user)

        expect(circle.is_member?(user)).to eq false
        expect(circle.is_pending?(user)).to eq true
      end

      it 'allows a user to leave if pending' do
        circle = create(:circle, is_public: false)
        circle.add_pending(user)

        expect(circle.is_pending? user).to eq true
        circle.remove_member(user)

        expect(circle.is_pending? user).to eq false
        expect(circle.is_member? user).to eq false
      end
    end

    describe "permissions" do
      subject { ability }
      let(:user) { create(:user) }
      let(:circle) { create(:circle) }
      let(:ability) { Ability.new(user) }

      describe "with admin" do
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

      describe "with admin" do
        before :each do
          circle.add_admin(user)
        end

        context "is allowed" do
          it { should be_able_to :read, circle }
          it { should be_able_to :update, circle }
          it { should be_able_to :create, Circle }
        end

        context "is NOT allowed" do
          it { should be_able_to :destroy, circle }
        end
      end

      describe "member" do
        before :each do
          circle.add_member(user)
        end

        context "is allowed" do
          it { should be_able_to :read, circle }
          it { should be_able_to :leave, circle }
          it { should be_able_to :create, Circle } # even if a user is a member, they should still be able to make a circle themselves
        end

        context "is not allowed to" do
          it { should_not be_able_to :destroy, circle }
          it { should_not be_able_to :update, circle }
        end
      end
    end
  end

end
