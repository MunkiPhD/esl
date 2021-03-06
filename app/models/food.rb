# == Schema Information
#
# Table name: foods
#
#  id                      :integer          not null, primary key
#  name                    :string(255)      default("")
#  brand                   :string(255)      default("")
#  ndb_no                  :string(6)        default("")
#  ingredients             :text             default("")
#  usda                    :boolean          default(FALSE)
#  serving_size            :string(255)      default("1 serving"), not null
#  calories                :integer          default(0), not null
#  calories_from_fat       :integer          default(0), not null
#  total_fat               :decimal(, )      default(0.0), not null
#  saturated_fat           :decimal(, )      default(0.0), not null
#  trans_fat               :decimal(, )      default(0.0), not null
#  polyunsaturated_fat     :decimal(, )      default(0.0), not null
#  monounsaturated_fat     :decimal(, )      default(0.0), not null
#  cholesterol             :decimal(, )      default(0.0), not null
#  sodium                  :decimal(, )      default(0.0), not null
#  carbs                   :decimal(, )      default(0.0), not null
#  dietary_fiber           :decimal(, )      default(0.0), not null
#  sugars                  :decimal(, )      default(0.0), not null
#  protein                 :decimal(, )      default(0.0), not null
#  vitamin_a               :integer          default(0), not null
#  vitamin_c               :integer          default(0), not null
#  calcium                 :integer          default(0), not null
#  iron                    :integer          default(0), not null
#  vitamin_d               :integer          default(0), not null
#  vitamin_e               :integer          default(0), not null
#  vitamin_k               :integer          default(0), not null
#  thiamin                 :integer          default(0), not null
#  riboflavin              :integer          default(0), not null
#  niacin                  :integer          default(0), not null
#  vitamin_b6              :integer          default(0), not null
#  biotin                  :integer          default(0), not null
#  pantothenic_acid        :integer          default(0), not null
#  phosphorus              :integer          default(0), not null
#  iodine                  :integer          default(0), not null
#  magnesium               :integer          default(0), not null
#  zinc                    :integer          default(0), not null
#  selenium                :integer          default(0), not null
#  copper                  :integer          default(0), not null
#  manganese               :integer          default(0), not null
#  chromium                :integer          default(0), not null
#  molybednum              :integer          default(0), not null
#  caffeine                :integer          default(0), not null
#  alcohol                 :integer          default(0), not null
#  potassium               :decimal(, )      default(0.0), not null
#  folic_acid              :integer          default(0), not null
#  boron                   :decimal(, )      default(0.0), not null
#  decimal                 :decimal(, )      default(0.0), not null
#  cobalt                  :decimal(, )      default(0.0), not null
#  chloride                :decimal(, )      default(0.0), not null
#  fluoride                :decimal(, )      default(0.0), not null
#  acetic_acid             :decimal(, )      default(0.0), not null
#  citric_acid             :decimal(, )      default(0.0), not null
#  lactic_acid             :decimal(, )      default(0.0), not null
#  malic_acid              :decimal(, )      default(0.0), not null
#  choline                 :decimal(, )      default(0.0), not null
#  taurine                 :decimal(, )      default(0.0), not null
#  glutamine               :decimal(, )      default(0.0), not null
#  creatine                :decimal(, )      default(0.0), not null
#  sugar_alcohols          :decimal(, )      default(0.0), not null
#  created_at              :datetime
#  updated_at              :datetime
#  food_image_file_name    :string(255)
#  food_image_content_type :string(255)
#  food_image_file_size    :integer
#  food_image_updated_at   :datetime
#

class Food < ActiveRecord::Base
	include NiceUrl
	include PgSearch

	before_validation :sum_calories

	has_many :log_foods
	has_attached_file :food_image,
		styles: { medium: "250x250>", thumb: "50x50>" }, 
		default_url: ":style_apple.png"

	validates_attachment :food_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
	validates_attachment_size :food_image, less_than_or_equal_to: 2.megabytes, if: Proc.new { |import| !import.food_image.file? }


	validates :name, presence: true, length: { minimum: 2, maximum: 220 }, allow_blank: false
	validates :serving_size, presence: true, length: { minimum: 1, maximum: 150 }
	validates_numericality_of :calories, 
		:calories_from_fat,
		:total_fat,
		:saturated_fat,
		:trans_fat,
		:polyunsaturated_fat,
		:monounsaturated_fat,
		:cholesterol,
		:sodium,
		:carbs,
		:dietary_fiber,
		:sugars,
		:protein,
		:vitamin_a,
		:vitamin_c,
		:calcium,
		:iron,
		:vitamin_d,
		:vitamin_e,
		:vitamin_k,
		:thiamin,
		:riboflavin,
		:niacin,
		:vitamin_b6,
		:biotin,
		:pantothenic_acid,
		:phosphorus,
		:iodine,
		:magnesium,
		:zinc,
		:selenium,
		:copper,
		:manganese,
		:chromium,
		:molybednum,
		:caffeine,
		:alcohol,
		:potassium,
		:folic_acid,
		:boron,
		:cobalt,
		:fluoride,
		:acetic_acid,
		:citric_acid,
		:lactic_acid,
		:malic_acid,
		:choline,
		:taurine,
		:glutamine,
		:creatine,
		:sugar_alcohols,
		:chloride,
		greater_than_or_equal_to: 0

	pg_search_scope :search_for, against: [ [:name, "A"], [:brand, "B"] ], 
		using: {
			tsearch: { prefix: true }
		}

	private

	def sum_calories
		self.calories_from_fat = (9 * self.total_fat ||= 0)
		self.calories = (4 * self.protein ||= 0) + (4 * self.carbs ||= 0) + self.calories_from_fat ||= 0
	end
end
