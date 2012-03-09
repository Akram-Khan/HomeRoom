module ApplicationHelper

def logo
	image_tag "homeroom_logo.png", :alt => "Home Room"
end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
