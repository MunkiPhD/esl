# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)      default(""), not null
#

require 'spec_helper'
require 'cancan/matchers'

describe User do
  it "has a unique username" do
    user = create(:user, username: "steve")
    user2 = build(:user, username: "steve")
    expect {
      user2.save
    }.to change(User, :count).by(0)

    expect(user2).to have(1).errors_on(:username)
  end

  describe "abilities" do
    #subject { ability }
    #let(:ability){ Ability.new(user) }
    #let(:user){ nil }

    context "when is a circle admin" do
      it "should be able to have permissions to circle" do
        user = create(:user)
        circle = create(:circle, user: user)
        user.grant :admin #, circle
        ability = Ability.new(user)
        expect(ability.can? :manage, :all).to eq true
        expect(ability).to be_able_to(:update, circle)
      end

      it "has roles limited to circle" do
        user = create(:user)
        circle = create(:circle, user: user)
        user.grant :manage, circle
#        ability = Ability.new(user)
        expect(user.has_role? :manage, circle).to eq true

        user.revoke :manage, circle
        expect(user.has_role? :manage, circle).to eq false
        #expect(ability.can? :manage, circle).to eq true
        #expect(ability).to be_able_to(:update, circle)
      end
      #let(:user){ create(:user_circle_admin) }

      #it{ should be_able_to(:manage, Circle.new) }
    end
  end
end
