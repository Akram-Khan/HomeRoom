class RolesController < ApplicationController

	def create
		@user = User.find(params[:role][:user_id])
		.follow!(@user)
		redirect_to course_path(@course)
	end
end
