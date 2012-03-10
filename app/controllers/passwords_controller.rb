class PasswordsController < Devise::PasswordsController

	protected
	def after_sending_reset_password_instructions_path_for(resource_name)
      login_path
    end
end