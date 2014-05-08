# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Exercise.create(name: "Squat")
Exercise.create(name: "Deadlift")
Exercise.create(name: "Bench Press")


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

