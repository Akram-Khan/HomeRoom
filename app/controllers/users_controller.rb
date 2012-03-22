class UsersController < ApplicationController

	before_filter :authenticate_user!, :except => [:new,:create]
	#before_filter :correct_user, :only => :dashboard

	def dashboard
		@courses = Course.all
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def correct_user 
    	u = User.find(params[:id]) 
    	redirect_to(root_path) unless authorized_user?(u)
  	end

  	def authorized_user?(u)
    	u == current_user
  	end	
end
