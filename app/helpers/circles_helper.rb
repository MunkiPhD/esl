module CirclesHelper
  def join_leave_link(circle)
    if current_user.has_any_role? :god, { name: :member, resource: circle }, { name: :admin, resource: circle }
      # show the leave link unless theyre the creator of the circle
      button_to 'Leave', leave_circle_path(circle.id), method: :post unless current_user == circle.user
    else
      button_to 'Join', join_circle_path(circle.id)
    end
  end
end
