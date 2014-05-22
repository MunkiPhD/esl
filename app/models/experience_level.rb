class ExperienceLevel < ActiveRecord::Base
	validates :name, presence: true, null: false
end
