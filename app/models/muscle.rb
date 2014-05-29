# == Schema Information
#
# Table name: muscles
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Muscle < ActiveRecord::Base
	include NiceUrl

	validates :name, presence: true, null: false
end
