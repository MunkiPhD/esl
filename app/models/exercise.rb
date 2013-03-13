# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Exercise < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: {minimum: 3, maximum:45}
  validates :user_id, presence: true
end
