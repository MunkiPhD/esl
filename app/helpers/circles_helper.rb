module CirclesHelper
  def join_leave_link(circle)
    return create_join_apply_button(circle) if current_user.blank?

    if circle.is_admin?(current_user)
      return button_to 'Leave', leave_circle_members_path(circle.id), method: :post
    end

    if circle.is_member? current_user
      return button_to 'Leave', leave_circle_members_path(circle.id), method: :post
    end

    if circle.is_pending? current_user
      return button_to 'Cancel Membership Request', leave_circle_members_path(circle.id), method: :post
    end

    return create_join_apply_button(circle)
  end

  # generates a link to display to admins how many members are awaiting approval
  def link_to_awaiting_approval(circle)
    return if current_user.blank? # check for if the user is currently signed in

    if circle.is_admin? current_user
      link_to "Awaiting Approval (#{circle.pending_members.count})", pending_circle_members_path(circle), 
        { class: 'circle-members-awaiting-approval' } if circle.pending_members.count > 0
    end
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
