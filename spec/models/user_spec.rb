# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  password_salt          :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)      default(""), not null
#

require 'spec_helper'
require 'cancan/matchers'

describe User do
  it 'factory is valid' do
    user = build(:user)
    expect(user).to be_valid
  end

  describe "#favorite_food" do
    it 'returns the favorite food for the specified item' do
      user = create(:user)
      food = create(:food)
      favorite_food = create(:favorite_food, food: food, user: user)
      expect(user.favorite_food(food)).to eq favorite_food
    end

    it 'returns a blank favorite food if it does not exist' do
      user = create(:user)
      food = create(:food)
      expect(user.favorite_food(food)).to be_blank
    end
  end

	describe '.workout_sets' do
		it 'responds to workout_sets' do
			user = create(:user)
			expect(user).to respond_to :workout_sets
		end

		it 'retrieves the workout_sets' do
			user = create(:user)
			workout = create(:workout_with_exercises, user: user)
			workout2 = create(:workout_with_exercises, user: create(:user))
			expect(user.workout_sets).to eq workout.workout_sets
		end
	end

  context 'validations' do
    describe 'username' do
      it "is unique" do
        user = create(:user, username: "steve")
        user2 = build(:user, username: "steve")
        expect {
          user2.save
        }.to change(User, :count).by(0)

        expect(user2).to have(1).errors_on(:username)
      end


      it "has no spaces" do
        user = build(:user, username: "steve martin")
        expect(user).to have(1).errors_on(:username)
      end

      it "can only be alphanumeric" do
        user = build(:user, username: "steve!martin")
        expect(user).to have(1).errors_on(:username)

        user.username = "stevemartin2"
        expect(user).to have(0).errors_on(:username)
      end

      it "allows _ character" do
        user = build(:user, username: "steve_martin")
        expect(user).to have(0).errors_on(:username)
      end

      it "does not allow - character" do
        user = build(:user, username: "steve-martin")
        expect(user).to have(1).errors_on(:username)
      end

      it 'does not allow just numbers' do
        user = build(:user, username: "12346")
        expect(user).to have(1).errors_on(:username)
      end

      it 'has at least one letter' do
        user = build(:user, username: "a12346")
        expect(user).to have(0).errors_on(:username)
      end

      it 'does not have to start with a letter' do
        user = build(:user, username: "1stevemartin")
        expect(user).to have(0).errors_on(:username)

        user.username = "_stevemartin"
        expect(user).to have(0).errors_on(:username)
      end
    end
  end

  describe "abilities" do
    #subject { ability }
    #let(:ability){ Ability.new(user) }
    #let(:user){ nil }

    context "when is a circle admin" do
      it "should be able to have permissions to circle" do
        user = create(:user)
        circle = create(:circle, user: user)
        circle.add_admin(user)
        ability = Ability.new(user)
        expect(ability.can? :manage, circle).to eq true
        expect(ability).to be_able_to(:update, circle)
      end

      it "has roles limited to circle" do
        user = create(:user)
        circle = create(:circle, user: user)
        user.grant :manage, circle
        expect(user.has_role? :manage, circle).to eq true

        user.revoke :manage, circle
        expect(user.has_role? :manage, circle).to eq false
      end
    end
  end
end
