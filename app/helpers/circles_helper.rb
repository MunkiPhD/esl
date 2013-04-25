module CirclesHelper
  def join_leave_link(circle)
    if current_user.blank?
      return create_join_apply_button(circle)
    end

    if circle.is_admin?(current_user)
      return button_to 'Leave', leave_circle_members_path(circle.id), method: :post
    end

    if circle.is_member? current_user
      return button_to 'Leave', leave_circle_members_path(circle.id), method: :post
    end

    if circle.is_pending? current_user
      return button_to 'Cancel Membership Request', leave_circle_members_path(circle.id), method: :post
    end

    #if current_user.has_any_role? :god, { name: :member, resource: circle }, { name: :admin, resource: circle }
      # show the leave link unless theyre the creator of the circle
    #  button_to 'Leave', leave_circle_path(circle.id), method: :post
    #else
     return create_join_apply_button(circle)
    #end
  end

  private

  def create_join_apply_button(circle)
    if circle.is_public
      button_to 'Join', join_circle_members_path(circle.id)
    else
      button_to 'Apply', join_circle_members_path(circle.id)
    end
  end
end
