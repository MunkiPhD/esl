class Muscle < ActiveRecord::Base
	validates :name, presence: true
end
