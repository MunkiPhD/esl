class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      #can :read, :all
      can :join, Circle, is_public: true # only allows you to see a page for a circle if it's public
      can :read, Circle, id: Circle.with_role(:circle_member, user).map(&:id)
      can :leave, Circle, id: Circle.with_role(:circle_member, user).map(&:id)
      can :manage, Circle, id: Circle.with_role(:circle_admin, user).map(&:id) # allow the person that's an admin to modify a circle
      #can :read, Circle, id: Circle.with_role(:circle_member, user).map(&:id) # allow members to read the circles
    end
    #if user.admin?
    #  can :manage, :all
    #else
    #  can :read, :all
    #end
  end
end
