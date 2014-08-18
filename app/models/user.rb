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

class User < ActiveRecord::Base
	rolify
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	attr_accessor :login

	enum gender: { unknown: 0, male: 1, female: 2 }

	has_many :workouts
	has_many :workout_templates
	has_many :circles
	has_many :log_foods
	has_many :favorite_foods
	has_many :workout_sets, through: :workouts
	has_one :nutrition_goal
	has_one :user_preferences, inverse_of: :user
	has_many :body_weights
	has_many :body_measurements

	accepts_nested_attributes_for :user_preferences

	validates :username, uniqueness: true,
		format: { with: /\A(?=.*[a-z])[a-z\_\d]+\Z/i, message: "Only alphanumeric letters and underscores allowed" }

	validate :birth_date_must_be_in_the_past
	validates :gender, presence: true
	validates :height, numericality: { greater_than_or_equal_to: 54, less_than_or_equal_to: 251, only_integer: false }, if: "height.present?"


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


	def preferences
		UserPreferences.find_or_create_by(user: self)
	end

	def age
		return nil unless birth_date.present?
		today = Date.today
		age = today.year - birth_date.year
		age -= 1 if birth_date.strftime("%m%d").to_i > today.strftime("%m%d").to_i
		age
	end

	def bmi
	end

	private 

	def self.by_login(login_value)
		where("lower(username) = :value OR lower(email) = :value", { value: login_value.downcase })
	end

	def birth_date_must_be_in_the_past
		if birth_date.present? && birth_date > Date.today
			errors.add(:birth_date, "must be in the past!")
		end
	end
end
