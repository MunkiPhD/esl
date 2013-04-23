class Circle < ActiveRecord::Base
  resourcify 
  after_create :add_admin_role_to_creator

  belongs_to :user

  validates :name, presence: true, 
                   uniqueness: true, 
                   length: { minimum: 3, maximum: 50 }
  validates :motto, length: { maximum: 50 }
  validates :user, presence: true
  validates :is_public, inclusion: { in: [true, false] }


  # adds member rights to the specified user
  def add_member(user)
    user.grant :member, self unless user.has_role? :member, self
  end


  # adds administrator rights to the specified user
  def add_admin(user)
    add_member(user)
    user.grant :admin, self unless user.has_role? :admin, self
  end


  # removes a member from the group by revoking all the rights
  def remove_member(user)
    user.revoke :admin, self if user.has_role? :admin, self
    user.revoke :member, self if user.has_role? :member, self
  end


  # returns a list of circle members as a relation, or an empty array
  def members
    assigned = self.roles.find_by_name(:member)
    unless assigned.nil?
      assigned.users.scoped
    else
      []
    end
  end


  # tests whether a user is a member of the current circle instance
  def is_member?(user)
    !members.where('user_id = ?', user.id).take.nil?
  end


  def self.memberships_for_user(user)
    resource_ids = Circle.find_roles(:member, user).pluck(:resource_id)
    Circle.where(id: resource_ids)
  end


  private
  def add_admin_role_to_creator
    add_admin self.user
  end
end
