
class Users::SessionsController < Devise::SessionsController
  def build_resource(hash=nil)
    hash ||= resource_params || {}
    self.resource = resource_class.new_with_session(hash, session)
  end


  def resource_params
    params.permit(:user).permit(:login, :password, :password_confirmation, :remember_me)
  end
  private :resource_params
end
