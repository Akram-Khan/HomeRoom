class UsersController < ApplicationController

	before_filter :correct_user, :only => :user_home

	def user_home
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
