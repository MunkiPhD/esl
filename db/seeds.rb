require 'open-uri'

puts 'Starting to seed data!'

# delete all the units so we can seed them again
puts 'Deleting all the units...'
Unit.delete_all

puts 'Adding Units...'
# order is important for the units as the enums will reflect the values
Unit.new(unit_type: 0, unit_type_name: "duration", unit_system: 0, unit_system_name: "US", unit_name: "milliseconds", unit_abbr: "ms").save(validate: false)
Unit.new(unit_type: 1, unit_type_name: "distance", unit_system: 0, unit_system_name: "US", unit_name: "miles", unit_abbr: "mi").save(validate: false)
Unit.new(unit_type: 2, unit_type_name: "elevation", unit_system: 0, unit_system_name: "US", unit_name: "feet", unit_abbr: "ft").save(validate: false)
Unit.new(unit_type: 3, unit_type_name: "height", unit_system: 0, unit_system_name: "US", unit_name: "inches", unit_abbr: "in").save(validate: false)
Unit.new(unit_type: 4, unit_type_name: "weight", unit_system: 0, unit_system_name: "US", unit_name: "pounds", unit_abbr: "lbs").save(validate: false)
Unit.new(unit_type: 5, unit_type_name: "measurements", unit_system: 0, unit_system_name: "US", unit_name: "inches", unit_abbr: "in").save(validate: false)
Unit.new(unit_type: 6, unit_type_name: "liquids", unit_system: 0, unit_system_name: "US", unit_name: "fluid ounces", unit_abbr: "fl oz").save(validate: false)
Unit.create(unit_type: 7, unit_type_name: "blood glucose", unit_system: 0, unit_system_name: "US", unit_name: "milligrams per decilitre", unit_abbr: "mg/dL").save(validate: false)

Unit.new(unit_type: 0, unit_type_name: "duration", unit_system: 1, unit_system_name: "METRIC", unit_name: "milliseconds", unit_abbr: "ms").save(validate: false)
Unit.new(unit_type: 1, unit_type_name: "distance", unit_system: 1, unit_system_name: "METRIC", unit_name: "kilometers", unit_abbr: "km").save(validate: false)
Unit.new(unit_type: 2, unit_type_name: "elevation", unit_system: 1, unit_system_name: "METRIC", unit_name: "meters", unit_abbr: "m").save(validate: false)
Unit.new(unit_type: 3, unit_type_name: "height", unit_system: 1, unit_system_name: "METRIC", unit_name: "centimeters", unit_abbr: "cm").save(validate: false)
Unit.new(unit_type: 4, unit_type_name: "weight", unit_system: 1, unit_system_name: "METRIC", unit_name: "kilograms", unit_abbr: "kgs").save(validate: false)
Unit.new(unit_type: 5, unit_type_name: "measurements", unit_system: 1, unit_system_name: "METRIC", unit_name: "centimeters", unit_abbr: "cm").save(validate: false)
Unit.new(unit_type: 6, unit_type_name: "liquids", unit_system: 1, unit_system_name: "METRIC", unit_name: "milliliters", unit_abbr: "ml").save(validate: false)
Unit.new(unit_type: 7, unit_type_name: "blood glucose", unit_system: 1, unit_system_name: "METRIC", unit_name: "millimoles per litre", unit_abbr: "mmol/l").save(validate: false)


puts ""

# create muscles
puts 'Adding Muscles...'
%w(Abdominals Abductors Adductors Biceps Calves Chest Forearms Glutes Hamstrings Lats Neck Quadriceps Shoulders Traps Triceps).each do |muscle|
	Muscle.find_or_create_by(name: muscle)
	print "."
end
Muscle.find_or_create_by(name: "Lower Back")
Muscle.find_or_create_by(name: "Middle Back")

puts ""

# exercise types
puts 'Adding Exercise Types'
%w(Cardio Plyometrics Powerlifting Strength Stretching Strongman).each do |exercise|
	ExerciseType.find_or_create_by(name: exercise)
	print "."
end
ExerciseType.find_or_create_by(name: 'Olympic Weightlifting')


def get_reference(klass, name)
	klass.find_or_create_by(name: name)
end

puts ""

# load the exercise data :: although this is inefficient with always hitting the db, it's only done once for a small dataset, so who cares
puts "Loading Exercises"
Exercise.delete_all
json_data = JSON.load(open('https://github.com/MunkiPhD/exercise_data/raw/master/exercise_data.json'))
json_data.each do |item|
	Exercise.find_or_create_by(name: item["name"]) do |exercise|
		exercise.alternate_name = item["also_known_as"]
		exercise.other_muscles = item["other_muscles"]
		exercise.equipment = get_reference(Equipment, item["equipment"] ||= "None")
		exercise.force_type = get_reference(ForceType, item["force"] ||= "N/A")
		exercise.mechanic_type = get_reference(MechanicType, item["mechanics_type"] ||= "N/A")
		exercise.muscle = get_reference(Muscle, item["main_muscle_worked"] ||= "N/A")
		exercise.experience_level = get_reference(ExperienceLevel, item["level"] ||= "Beginner")
		exercise.exercise_type = get_reference(ExerciseType, item["type"] ||= "N/A")
		exercise.instructions = item["directions"]
	end
	print "."
end

puts ""

# The following code was copied from the old EatSleepLift.com. It is messy and crappy, but it works, and it is only a one time deal.
require 'active_record'
require 'activerecord-import'
require "activerecord-import/base"
ActiveRecord::Import.require_adapter('postgresql')
require 'open-uri'

Food.delete_all

# --------------------------------
# Generates a hash for all the weights specified for each ndb_no
# --------------------------------
def generate_weight_hash
	#file_location = File.join(RAILS_ROOT, "/data_import/", "WEIGHT.txt")
	#file = File.new(file_location, "r")
	puts "Generating Weight Hash..."
	weights = {}
	longest_serving_size = 0
	open("https://raw.githubusercontent.com/MunkiPhD/ndb_data/master/WEIGHT.txt") { |f|
		f.each_line { |line|
			#while(line = file.gets)
			vals = line.split('^')
			ndb_no = remove_delimeter vals[0]
			sequence = vals[1]
			amount = vals[2]
			description = "#{amount} #{remove_delimeter vals[3]}"
			grams = vals[4].to_f

			internal = { :grams => grams, :serving_size => description }

			if weights[ndb_no].nil?
				weights[ndb_no] = {}
			end

			if description.length > longest_serving_size
				longest_serving_size = description.length
			end

			weights[ndb_no].store(sequence, internal)
			#	end
		}}

		puts "Longest serving size length: #{longest_serving_size}"
		puts "#{weights.count} Food items with known weight measurements"
		puts "Completed weight hash generation"

		return weights # lets make it explicit so that we know
end



# ---------------------------------------
#
# This will set all the values correctly based on the gram weight
#
# ---------------------------------------
def mold_food(food, values, ndb_no, gram_weight, additional_nutrients)
	food.total_fat = denormalize(gram_weight, values[5]).to_i
	food.calories_from_fat = (denormalize(gram_weight, values[5]).to_i) * 9
	food.saturated_fat = denormalize gram_weight, values[44]
	food.polyunsaturated_fat = denormalize gram_weight, values[46]
	food.monounsaturated_fat = denormalize gram_weight, values[45]
	food.cholesterol = denormalize gram_weight, values[47]
	food.sodium = denormalize gram_weight, values[15]
	food.carbs = denormalize(gram_weight, values[7]).to_i
	food.dietary_fiber = denormalize gram_weight, values[8]
	food.sugars = denormalize gram_weight, values[9]
	food.protein = denormalize(gram_weight, values[4]).to_i
	food.vitamin_a = denormalize gram_weight, values[32]
	food.vitamin_c = denormalize gram_weight, values[20]
	food.calcium = denormalize gram_weight, values[10]
	food.iron = denormalize gram_weight, values[11]
	food.vitamin_d = denormalize gram_weight, values[41]
	food.vitamin_e = denormalize gram_weight, values[40]
	food.vitamin_k = denormalize gram_weight, values[43]
	food.thiamin = denormalize gram_weight, values[21]
	food.riboflavin = denormalize gram_weight, values[22]
	food.niacin = denormalize gram_weight, values[23]
	food.vitamin_b6 = denormalize gram_weight, values[25]
	food.pantothenic_acid = denormalize gram_weight, values[24]
	food.phosphorus = denormalize gram_weight, values[13]
	food.magnesium = denormalize gram_weight, values[12]
	food.zinc = denormalize gram_weight, values[16]
	food.selenium = denormalize gram_weight, values[19]
	food.copper = denormalize gram_weight, values[17]
	food.manganese = denormalize gram_weight, values[18]

	food
end

# ----------------------------------------
# Denormalizes the weight to the actual value for that measurement
# ----------------------------------------
def denormalize(gram_weight, value)
	if value.nil? || value == ""
		return 0
	end

	(value.to_f * gram_weight) / 100
end

# -------------------------------------------
# we're going to create a hash of the names for the NDB_IDs so that we can add it to the description
# -------------------------------------------
def generate_food_names_hash
	puts "Generating the food name hash..."
	food_names = {}
	longest_string = 0
	p "Starting to get the file..."
	open("https://github.com/MunkiPhD/ndb_data/raw/master/FOOD_DES.txt") { |f|
		f.each_line { |line| 

			split_line = line.split('^')

			# we need to trim the ~ from the beginning and the ends of the strings
			ndb_id = remove_delimeter split_line[0]
			name = remove_delimeter split_line[2]
			brand = remove_delimeter split_line[5]

			print "."
			# the ndb_id is the first value
			food_names[ndb_id] = {:name => name, :brand => brand}

			if name.size > longest_string
				longest_string = name.size
			end 
		}}

		puts ""
		puts "Longest name length was #{longest_string}"
		puts "Completed generating the food name hash. #{food_names.count} items added"

		return food_names
end

# -------------------------------------------
# Retrieves a hash of the missing nutrients with ndb_no as the key
# -------------------------------------------
def get_missing_nutrients_hash
	puts "Generating missing nutrients hash..."
	additional_nutrients = {}
	open("https://github.com/MunkiPhD/ndb_data/raw/master/NUT_DATA.txt") { |f|
		f.each_line{ |line|
			split_line = line.split('^')
			nutrient_id = split_line[1]
			ndb_no = remove_delimeter split_line[0]

			additional_nutrients[ndb_no] = { :alcohol => 0, :caffeine => 0 } # initialize the hash inside the hash

			# if the nutrient we're looking for is alcohol, set it in the nested hash
			if nutrient_id == "221" # alcohol
				additional_nutrients[ndb_no].store :alcohol, split_line[2].to_f
			end

			# if the nutrient we're looking for is caffeine, set it in the nested hash
			if nutrient_id == "262" # caffeine
				additional_nutrients[ndb_no].store :caffeine, split_line[2].to_f
			end

		}}

		puts "Completed generating missing nutrients list."

		return additional_nutrients
end

# -------------------------------------------
# Removes the "~" character from the beginning and the end of a string
# -------------------------------------------
def remove_delimeter(str)
	str[1..-2]
end

puts "about to start food imports..."
#===========================================================
begin
	foods = []
	split_hash = ""
	food_names = generate_food_names_hash
	additional_nutrients = "" # get_missing_nutrients_hash
	weights = generate_weight_hash

	open("https://github.com/MunkiPhD/ndb_data/raw/master/ABBREV.txt") { |f|
		f.each_line {|line|
			split_hash = line.split('^')

			ndb_no = remove_delimeter split_hash[0]

			unless weights[ndb_no].nil? # if it's not null, we're going to iterate over all the weights for this food item
				weights[ndb_no].each do |sequence, subvalue|

					# puts ">> GRAMS: #{weights[key][sequence].fetch :grams} SERVING_SIZE: #{weights[key][sequence].fetch :serving_size}" 
					food_name = "" 
					brand_name = ""

					begin
						food_name = food_names[ndb_no].fetch :name
						brand_name = food_names[ndb_no].fetch :brand
					rescue  
						puts "Failed when getting the name/brand name for #{ndb_no}: #{$!}"
					end

					serving_size = weights[ndb_no][sequence].fetch :serving_size
					gram_weight = weights[ndb_no][sequence].fetch :grams

					food_instance = Food.new
					food_instance.ndb_no = ndb_no
					food_instance.name = "#{food_name} (#{serving_size})"
					food_instance.brand = brand_name
					food_instance.usda = true
					food_instance.serving_size = "#{serving_size} (#{gram_weight})"

					foods << mold_food(food_instance, split_hash, ndb_no, gram_weight, additional_nutrients)

					if !food_instance.valid?
						puts "Errors for #{food_instance.name}: "
						food_instance.errors.full_messages.each do |error|
							">> #{error}"
						end
						puts "\n"
					end #end if
				end # end inner weights iteration
				#  end # end outer weights iteration
			end # end unless condition

		}}
		puts "=============================="
		puts "Beginning database insert..."

		before_insert = Food.count
		puts "Total Food count in DB before bulk insert: #{before_insert}";

		# perform the actual import
		Food.import foods, :validate => true #, :on_duplicate_key_update => [:name]

		puts "Database insert finished"
		after_insert = Food.count
		puts "Total food count in Database: #{after_insert}"
		puts "#{after_insert - before_insert} items added successfully."

		puts "\n >> Happy Eating! << \n"

rescue Exception => e
	puts e.message
	puts e.backtrace.inspect
end

puts "Seeding complete!"
