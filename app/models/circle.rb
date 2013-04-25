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


  # manages a users membership request
  def request_membership(user)
    if self.is_public
      add_member(user)
    else
      add_pending(user)
    end
  end

  # approves membership of user
  #    user: user to be approved
  #    admin: admin that is approving the requested membership
  def approve_membership(user, admin)
    if is_admin? admin
      add_member(user) if is_pending? user
    end
  end

  # adds pending rights to the specified user
  def add_pending(user)
    user.grant :pending, self unless user.has_role? :member, self
  end

  # adds member rights to the specified user
  def add_member(user)
    user.revoke :pending, self if user.has_role? :pending, self
    user.grant :member, self unless user.has_role? :member, self
  end


  # adds administrator rights to the specified user
  def add_admin(user)
    add_member(user)
    user.grant :admin, self unless user.has_role? :admin, self
  end


  # removes a member from the group by revoking all the rights
  def remove_member(user)
    user.revoke :pending, self if user.has_role? :pending, self
    user.revoke :member, self if user.has_role? :member, self
    user.revoke :admin, self if user.has_role? :admin, self
  end


  # returns a list of users pending approval to become members as a relation or an empty array
  def pending_members
    get_users_with_roles :pending
  end

  # returns a list of circle members as a relation or an empty array
  def members
    get_users_with_roles :member
  end


  # returns a list of circle admins as a relation or an empty array
  def admins
    get_users_with_roles :admin
  end


  def is_pending?(user)
    is_user_in_role_group pending_members, user
  end


  # tests whether a user is a member of the current circle instance
  def is_member?(user)
    is_user_in_role_group members, user
  end


  # checks to see if the specified user has admin role
  def is_admin?(user)
    is_user_in_role_group admins, user
  end


  # CLASS METHOD that gets all the circles where a user is a member of (since admins also get member role, they should be covered as well)
  def self.memberships_for_user(user)
    resource_ids = Circle.find_roles(:member, user).pluck(:resource_id)
    Circle.where(id: resource_ids)
  end


  private
  def add_admin_role_to_creator
    add_admin self.user
  end

  def is_user_in_role_group(role_group, user)
    unless role_group.empty?
      !role_group.where('user_id = ?', user.id).take.nil?
    else
      false
    end
  end


  # returns a list of users with the specified role, or an empty array
  def get_users_with_roles(role)
    assigned = self.roles.find_by_name(role)
    unless assigned.nil?
      assigned.users.scoped
    else
      []
    end
  end
end
