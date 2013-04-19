class Circle < ActiveRecord::Base
  resourcify 
  after_create :add_admin_role_to_creator

  belongs_to :user

  validates :name, presence: true, 
                   uniqueness: true, 
                   length: { minimum: 3, maximum: 50 }
  validates :motto, length: { maximum: 50 }
  validates :user, presence: true
  validates :is_public, presence: true

  private
  def add_admin_role_to_creator
    self.user.grant :circle_admin, self 
  end
end
