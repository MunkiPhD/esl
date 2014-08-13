class AthletesController < ApplicationController
	def show
	end

	def edit
	end

	def update
		respond_to do |format|
			if current_user.update(athlete_params)
				flash[:success] = "Information was updated."
				format.html { redirect_to athlete_path(current_user) }
			else
				flash[:error] = "Could not save data"
				format.html { render :edit }
			end
		end
	end

	private
	def athlete_params
		params.require(:user).permit(:height, :birth_date, :gender)
	end
end
