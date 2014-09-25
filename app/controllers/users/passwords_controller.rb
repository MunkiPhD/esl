class Users::PasswordsController < ApplicationController
	before_filter :authenticate_user!
	respond_to :html

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update_with_password(user_params)
			sign_in @user, bypass: true
			flash[:success] = "Password Updated Successfully"
			redirect_to athlete_path(current_user)
		else
			flash[:error] = "Errors updating your password"
			render 'edit'
		end
	end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
