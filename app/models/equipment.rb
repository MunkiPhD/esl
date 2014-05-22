class Equipment < ActiveRecord::Base
	validates :name, presence: true, null: false
end
