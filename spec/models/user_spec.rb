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
#  height                 :decimal(4, 2)
#  gender                 :integer          default(0), not null
#  birth_date             :datetime
#

require 'rails_helper'
require 'cancan/matchers'

describe User do
	let(:user) { create(:user) }

	it 'factory is valid' do
		user = build(:user)
		expect(user).to be_valid
	end

	describe '#age' do
		it 'returns the users age if a birth_date is present' do
			Timecop.freeze(Date.today) do
				user = create(:user, birth_date: 20.years.ago)
				expect(user.age).to eq 19
			end
		end

		it 'returns null if no birth_date is present' do
			user = create(:user, birth_date: nil)
			expect(user.age).to eq nil
		end	
	
		it 'has correct age based on a date' do
			Timecop.freeze(Date.new(2010, 4, 4)) do
				user = create(:user, birth_date: Date.new(1976, 4, 10))
				expect(user.age).to eq 33
			end
		end

		it 'has correct age on a date 2' do 
			Timecop.freeze(Date.new(2010, 4, 14)) do
				user = create(:user, birth_date: Date.new(1976, 4, 10))
				expect(user.age).to eq 34
			end
		end
	end


	describe '#bmi' do
		it 'returns bmi if there is height and a weight entry for US system' do
			user = create(:user, height: 70, birth_date: 20.years.ago)
			weight = create(:body_weight, user: user, weight: 200)
			expect(user.bmi).to eq 28.69
		end

		it 'returns null if no body weight' do
			pending
		end


		it 'returns null if no height' do
			pending
		end
	end

	describe "#favorite_food" do
		it 'returns the favorite food for the specified item' do
			food = create(:food)
			favorite_food = create(:favorite_food, food: food, user: user)
			expect(user.favorite_food(food)).to eq favorite_food
		end

		it 'returns a blank favorite food if it does not exist' do
			food = create(:food)
			expect(user.favorite_food(food)).to be_blank
		end
	end


	describe '.workout_sets' do
		it 'responds to workout_sets' do
			expect(user).to respond_to :workout_sets
		end

		it 'retrieves the workout_sets' do
			workout = create(:workout_with_exercises, user: user)
			workout2 = create(:workout_with_exercises, user: create(:user))
			expect(user.workout_sets).to eq workout.workout_sets
		end
	end

	describe '.nutrition_goal' do
		it 'gets the correct nutriton goal' do
			nutrition_goal = create(:nutrition_goal, user: user)
			expect(user.nutrition_goal).to eq nutrition_goal	
		end
	end

	describe '.preferences' do
		it 'gets the correct preferences for the user' do
			preferences = create(:user_preferences, user: user)
			expect(user.preferences).to eq preferences
		end

		it 'creates preferences if non exist' do
			user = create(:user, user_preferences: nil)
			expect(user.preferences).to_not be_nil
		end
	end

	describe 'gender' do
		it 'defaults to "unknown"' do
			user = User.new
			expect(user.gender).to eq "unknown"
		end

		it 'can be "male"' do
			user = User.new(gender: 1)
			expect(user.gender).to eq "male"
		end

		it 'can be "female"' do
			user = User.new(gender: 2)
			expect(user.gender).to eq "female"
		end
	end

	context 'validations' do
		describe 'birth_date' do
			it 'can be null' do
				user = User.new(birth_date: nil)
				user.valid?
				expect(user.errors[:birth_date]).to eq []
			end

			it 'has a birth date that is at at least in the past' do
				Timecop.freeze(Date.today) do
					user = User.new(birth_date: Date.today + 1)
					user.valid?
					expect(user.errors[:birth_date]).to include "must be in the past!"
				end
			end
		end

		describe 'gender' do
			it 'cannot be null' do
				user = User.new(gender: nil)
				user.valid?
				expect(user.errors[:gender]).to include "can't be blank"
			end

			it 'defaults to "unknown"' do
				user = User.new
				expect(user.gender).to eq "unknown"
			end

			it 'can be male' do
				user = User.new(gender: 1)
				user.valid?
				expect(user.errors[:gender]).to eq []
			end


			it 'can be female' do
				user = User.new(gender: 2)
				user.valid?
				expect(user.errors[:gender]).to eq []
			end
		end

		describe 'height' do
			it 'can be null' do
				user = User.new(height: nil)
				user.valid?
				expect(user.errors[:height]).to eq []
			end

			it 'is greater than or equal to 54' do
				user = User.new(height: 52)
				user.valid?
				expect(user.errors[:height]).to include "must be greater than or equal to 54"
			end

			it 'is less than or equal to 251' do
				user = User.new(height: 252)
				user.valid?
				expect(user.errors[:height]).to include "must be less than or equal to 251"
			end
		end


		describe 'username' do
			it "is unique" do
				user = create(:user, username: "steve")
				user2 = build(:user, username: "steve")
				expect {
					user2.save
				}.to change(User, :count).by(0)

				expect(user2.errors[:username]).to include "has already been taken"
			end


			it "has no spaces" do
				user = build(:user, username: "steve martin")
				user.valid?
				expect(user.errors[:username]).to include 'Only alphanumeric letters and underscores allowed'
			end

			it "cannot be non-alphanumeric" do
				user = build(:user, username: "steve!martin")
				user.valid?
				expect(user.errors[:username]).to include 'Only alphanumeric letters and underscores allowed'
			end

			it "allows _ character" do
				user = build(:user, username: "steve_martin")
				user.valid?
				expect(user.errors[:username]).to eq []
			end

			it "does not allow - character" do
				user = build(:user, username: "steve-martin")
				user.valid?
				expect(user.errors[:username]).to include 'Only alphanumeric letters and underscores allowed'
			end

			it 'does not allow just numbers' do
				user = build(:user, username: "12346")
				user.valid?
				expect(user.errors[:username]).to include 'Only alphanumeric letters and underscores allowed'
			end

			it 'has at least one letter' do
				user = build(:user, username: "a12346")
				user.valid?
				expect(user.errors[:username]).to eq []
			end

			it 'does not have to start with a letter' do
				user = build(:user, username: "1stevemartin")
				user.valid?
				expect(user.errors[:username]).to eq []

				user.username = "_stevemartin"
				user.valid?
				expect(user.errors[:username]).to eq []
			end
		end
	end

	describe "abilities" do
		context "when is a circle admin" do
			it "should be able to have permissions to circle" do
				circle = create(:circle, user: user)
				circle.add_admin(user)
				ability = Ability.new(user)
				expect(ability.can? :manage, circle).to eq true
				expect(ability).to be_able_to(:update, circle)
			end

			it "has roles limited to circle" do
				circle = create(:circle, user: user)
				user.grant :manage, circle
				expect(user.has_role? :manage, circle).to eq true

				user.revoke :manage, circle
				expect(user.has_role? :manage, circle).to eq false
			end
		end
	end
end
