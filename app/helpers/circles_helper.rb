module CirclesHelper
  def join_leave_link(circle)
    if current_user.blank?
      return create_join_apply_button(circle)
    end

    if current_user.has_any_role? :god, { name: :member, resource: circle }, { name: :admin, resource: circle }
      # show the leave link unless theyre the creator of the circle
      button_to 'Leave', leave_circle_path(circle.id), method: :post
    else
      create_join_apply_button(circle)
    end
  end

  private

  def create_join_apply_button(circle)
    if circle.is_public
      button_to 'Join', join_circle_path(circle.id)
    else
      button_to 'Apply', join_circle_path(circle.id)
    end
  end
end
