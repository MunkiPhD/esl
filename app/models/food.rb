# == Schema Information
#
# Table name: foods
#
#  id          :integer          not null, primary key
#  name        :string(255)      default("")
#  brand       :string(255)      default("")
#  ndb_no      :string(6)        default("")
#  ingredients :text             default("")
#  usda        :boolean          default(FALSE)
#  decimal     :decimal(, )      default(0.0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Food < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2, maximum: 150 }, allow_blank: false
  validates :serving_size, presence: true, length: { minimum: 1, maximum: 75 }
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


  #
  # Used to override the default to_params so that it includes the name of the food
  #
  def to_param
    [id, name.parameterize].join("-")
  end


  #
  # Finds a Food based on the name (e.f. '112-fried-chicken-breast'
  #   input: the string
  #
  # Ruby will take the string and turn it into a number. 
  # Internally it will essentially just grab the first numbers and ignore the rest, so simply cast it as an integer
  def self.find_by_param(input)
    find(input.to_i)
  end


  #
  # Searches for food items with the name or brand like the passed query. Very crude SQL implementation using LIKE
  #
  def self.search_for(query_string)
    if query_string
      where('lower(name) ILIKE ? OR lower(brand) ILIKE ?', "%#{query_string.downcase}%", "%#{query_string.downcase}%")
    else
      Food.none
    end
  end
end
