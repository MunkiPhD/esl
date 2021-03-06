# app/controllers/users/registrations_controller.rb
 
class Users::RegistrationsController < Devise::RegistrationsController


    # POST /resource
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => self.after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

   # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    hash ||= resource_params || {}
    self.resource = resource_class.new_with_session(hash, session)
  end


  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me)
  end
  private :resource_params
end
