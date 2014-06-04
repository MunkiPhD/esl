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

class User < ActiveRecord::Base
	rolify
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	attr_accessor :login

	has_many :workouts
	has_many :circles
	has_many :log_foods
	has_many :favorite_foods
	has_many :workout_sets, through: :workouts
	has_one :nutrition_goal
	has_one :user_preferences, inverse_of: :user
	has_many :body_weights

	validates :username, uniqueness: true,
		format: { with: /\A(?=.*[a-z])[a-z\_\d]+\Z/i, message: "Only alphanumeric letters and underscores allowed" }


	# override the finder so that it searches by username OR email
	def self.find_for_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions).by_login(login).first
		else
			where(conditions).first
		end
	end

	def to_param
		username
	end

	def self.find(input)
		input.to_i == 0 ? find_by_username(input) : super
	end


	def favorite_food(food)
		self.favorite_foods.for_food(food).first
	end


	private 

	def self.by_login(login_value)
		where("lower(username) = :value OR lower(email) = :value", { value: login_value.downcase })
	end
end
