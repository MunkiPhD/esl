class Equipment < ActiveRecord::Base
	include NiceUrl

	validates :name, presence: true, null: false
end
