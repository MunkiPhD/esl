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

  def add_member(user)
    user.grant :circle_member, self unless user.has_role? :circle_member, self
  end

  def add_admin(user)
    user.grant :circle_admin, self
  end

  def circle_members
    assigned = self.roles.find_by_name(:circle_member)
    unless assigned.nil?
      assigned.users
    else
      []
    end
  end


  def self.memberships_for_user(user)
    resource_ids = Circle.find_roles(:circle_member, user).pluck(:resource_id)
    Circle.where(id: resource_ids)
  end


  private
  def add_admin_role_to_creator
    add_admin self.user
  end
end
