class SessionsController < Devise::SessionsController  
  	def new
    	resource = build_resource
    	clean_up_passwords(resource)
    	respond_to do |format|
        	format.js{render :partial => "new"}
        	format.html{render :template => "devise/sessions/new_without_js"} 
        end
  	end
end
