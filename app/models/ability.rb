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
    if user.has_role? :super_admin
      can :manage, :all
    else
      can :read, Circle
      can :join, Circle, is_public: true # only allows you to join a page for a circle if it's public
      can :read, Circle, id: Circle.with_role(:member, user).map(&:id)
      can :leave, Circle, id: Circle.with_role(:member, user).map(&:id)
      can :manage, Circle, id: Circle.with_role(:admin, user).map(&:id) # allow the person that's an admin to modify a circle
      can :pending, Circle, id: Circle.with_role(:admin, user).map(&:id)
      can :read, Workout # needs to look at circles, so look at the :show of the WorkoutsController for the permissions
      can :manage, Workout, user_id: user.id
      can :manage, LogFood, user_id: user.id
      can :manage, FavoriteFood, user_id: user.id
    end
  end
end
