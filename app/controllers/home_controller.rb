class HomeController < ApplicationController
	before_filter :redirect_if_logged_in

	def index
	end

	private

	def redirect_if_logged_in
		if user_signed_in?
			redirect_to dashboard_path
		end
	end
end
