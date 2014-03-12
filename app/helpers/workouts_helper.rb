module WorkoutsHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s + "_fields", :f => builder, exercises: @exercises)
    end
    
    link_to_add(name, "#", onClick: "Workouts.add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\"); return false;")
  end


  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_destroy(name, "#", onClick: "Workouts.remove_fields(this); return false;")
  end


  def workout_index_title(user)
    if user.username == current_user.username
      "My Workouts"
    else
      "#{user.username}'s Workouts"
    end
  end
 end
