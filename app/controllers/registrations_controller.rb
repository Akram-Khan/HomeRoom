class RegistrationsController < Devise::RegistrationsController

	def new
    	resource = build_resource({})
  	end
end